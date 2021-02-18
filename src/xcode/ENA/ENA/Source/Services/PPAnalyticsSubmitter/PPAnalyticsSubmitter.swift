////
// 🦠 Corona-Warn-App
//

import Foundation
import OpenCombine

protocol PPAnalyticsSubmitting {
	/// Triggers the submission of all collected analytics data. Only if all checks success, the submission is done. Otherwise, the submission is aborted. The completion calls are passed through to test the component.
	func triggerSubmitData(ppacToken: PPACToken?, completion: ((Result<Void, PPASError>) -> Void)?)

	#if !RELEASE
	/// ONLY FOR TESTING. Triggers for the dev menu a forced submission of the data, whithout any checks.
	func forcedSubmitData(completion: @escaping (Result<Void, PPASError>) -> Void)
	/// ONLY FOR TESTING. Return the constructed proto-file message to look into the data we would submit.
	func getPPADataMessage() -> SAP_Internal_Ppdd_PPADataIOS
	/// ONLY FOR TESTING. Returns the last submitted data.
	func mostRecentAnalyticsData() -> String?
	#endif
}

final class PPAnalyticsSubmitter: PPAnalyticsSubmitting {

	// MARK: - Init

	init(
		store: Store,
		client: Client,
		appConfig: AppConfigurationProviding
	) {
		self.store = store
		self.client = client
		self.configurationProvider = appConfig
	}

	// MARK: - Protocol PPAnalyticsSubmitting

	func triggerSubmitData(
		ppacToken: PPACToken? = nil,
		completion: ((Result<Void, PPASError>) -> Void)? = nil
	) {

		// Check if user has given his consent to collect data
		if userDeclinedAnalyticsCollectionConsent {
			Log.warning("Analytics submission abord due to missing users consent", log: .ppa)
			completion?(.failure(.userConsentError))
			return
		}

		configurationProvider.appConfiguration().sink { [weak self] configuration in

			guard let self = self else {
				Log.warning("Analytics submission abord due fail at creating strong self", log: .ppa)
				completion?(.failure(.generalError))
				return
			}

			// Check configuration parameter
			if Double.random(in: 0...1) > configuration.privacyPreservingAnalyticsParameters.common.probabilityToSubmit {
				Log.warning("Analytics submission abord due to randomness", log: .ppa)
				completion?(.failure(.probibilityError))
				return
			}

			// Last submission check
			if self.submissionWithinLast23Hours {
				Log.warning("Analytics submission abord due to submission last 23 hours", log: .ppa)
				completion?(.failure(.submission23hoursError))
				return
			}

			// Onboarding check
			if self.onboardingCompletedWithinLast24Hours {
				Log.warning("Analytics submission abord due to onboarding completed last 24 hours", log: .ppa)
				completion?(.failure(.onboardingError))
				return
			}

			// App Reset check
			if self.appResetWithinLast24Hours {
				Log.warning("Analytics submission abord due to app resetted last 24 hours", log: .ppa)
				completion?(.failure(.appResetError))
				return
			}

			if let token = ppacToken {
				// Submit analytics data with injected ppac token
				self.submitData(with: token, completion: completion)
			} else {
				self.generatePPACAndSubmitData(completion: completion)
			}
			
			self.hoursSinceTestResultToSubmitKeySubmissionMetadata = configuration.privacyPreservingAnalyticsParameters.common.hoursSinceTestResultToSubmitKeySubmissionMetadata
			self.hoursSinceTestRegistrationToSubmitTestResultMetadata = configuration.privacyPreservingAnalyticsParameters.common.hoursSinceTestRegistrationToSubmitTestResultMetadata

		}.store(in: &subscriptions)
	}

	#if !RELEASE

	func forcedSubmitData(completion: @escaping (Result<Void, PPASError>) -> Void) {
		generatePPACAndSubmitData(completion: completion)
	}

	func getPPADataMessage() -> SAP_Internal_Ppdd_PPADataIOS {
		return obtainUsageData()
	}

	func mostRecentAnalyticsData() -> String? {
		return store.lastSubmittedPPAData
	}

	#endif

	// MARK: - Public

	// MARK: - Internal

	// MARK: - Private

	private let store: Store
	private let client: Client
	private let configurationProvider: AppConfigurationProviding

	private var subscriptions = [AnyCancellable]()
	private var hoursSinceTestRegistrationToSubmitTestResultMetadata: Int32 = 0
	
	private var userDeclinedAnalyticsCollectionConsent: Bool {
		return !store.isPrivacyPreservingAnalyticsConsentGiven
	}

	private var hoursSinceTestResultToSubmitKeySubmissionMetadata: Int32 = 0

	private var submissionWithinLast23Hours: Bool {
		guard let lastSubmission = store.lastSubmissionAnalytics,
			  let twentyThreeHoursAgo = Calendar.current.date(byAdding: .hour, value: -23, to: Date()) else {
				return false
		}
		let lastTwentyThreeHours = twentyThreeHoursAgo...Date()
		return lastTwentyThreeHours.contains(lastSubmission)
	}

	private var onboardingCompletedWithinLast24Hours: Bool {
		// why the date of acceptedPrivacyNotice? See https://github.com/corona-warn-app/cwa-app-tech-spec/pull/19#discussion_r572826236
		guard let onbaordedDate = store.dateOfAcceptedPrivacyNotice,
			  let twentyFourHoursAgo = Calendar.current.date(byAdding: .hour, value: -24, to: Date()) else {
			return false
		}
		let lastTwentyFourHours = twentyFourHoursAgo...Date()
		return lastTwentyFourHours.contains(onbaordedDate)
	}

	private var appResetWithinLast24Hours: Bool {
		guard let lastResetDate = store.lastAppReset,
			  let twentyFourHoursAgo = Calendar.current.date(byAdding: .hour, value: -24, to: Date()) else {
			return false
		}
		let lastTwentyFourHours = twentyFourHoursAgo...Date()
		return lastTwentyFourHours.contains(lastResetDate)
	}

	private var shouldIncludeKeySubmissionMetadata: Bool {
		/* Conditions for submitting the data:
			submitted is true
			OR
			- differenceBetweenTestResultAndCurrentDateInHours >= hoursSinceTestResultToSubmitKeySubmissionMetadata
		*/
		var isSubmitted = false
		var timeDifferenceFulfilsCriteria = false

		// if submitted is true
		if store.keySubmissionMetadata?.submitted == true {
			isSubmitted = true
		} else {
			isSubmitted = false
		}

		// if there is no test result date
		guard let testResultDate = store.testResultDate else {
			return false
		}
		
		let differenceBetweenTestResultAndCurrentDate = Calendar.current.dateComponents([.hour], from: testResultDate, to: Date())
		if let differenceBetweenTestResultAndCurrentDateInHours = differenceBetweenTestResultAndCurrentDate.hour,
		   differenceBetweenTestResultAndCurrentDateInHours >= hoursSinceTestResultToSubmitKeySubmissionMetadata {
			timeDifferenceFulfilsCriteria = true
		}
		return isSubmitted || timeDifferenceFulfilsCriteria
	}

	private var shouldTestResultMetadataBeIncluded: Bool {
		/* Conditions for submitting the data:
			- testResult = positive
			OR
			- testResult = negative
			OR
			- differenceBetweenRegistrationAndCurrentDateInHours "Registration is stored In TestMetadata" >= hoursSinceTestRegistrationToSubmitTestResultMetadata "stored in appConfiguration"
		*/
		
		// If for some reason there is no registrationDate we should not submit the testMetadata
		guard let registrationDate = store.testResultMetadata?.testRegistrationDate else {
			return false
		}
				
		switch store.testResultMetadata?.testResult {
		case .positive, .negative:
			return true
		default:
			break
		}
		let differenceBetweenRegistrationAndCurrentDate = Calendar.current.dateComponents([.hour], from: registrationDate, to: Date())

		if let differenceBetweenRegistrationAndCurrentDateInHours = differenceBetweenRegistrationAndCurrentDate.hour,
		   differenceBetweenRegistrationAndCurrentDateInHours >= hoursSinceTestRegistrationToSubmitTestResultMetadata {
			return true
		}
		return false
	}

	private func generatePPACAndSubmitData(completion: ((Result<Void, PPASError>) -> Void)? = nil) {
		// Obtain authentication data
		let deviceCheck = PPACDeviceCheck()
		let ppacService = PPACService(store: self.store, deviceCheck: deviceCheck)

		// Submit analytics data with generated ppac token
		ppacService.getPPACToken { [weak self] result in
			switch result {
			case let .success(token):
				self?.submitData(with: token, completion: completion)
			case let .failure(error):
				Log.error("Could not submit analytics data due to ppac authorization error", log: .ppa, error: error)
				completion?(.failure(.ppacError(error)))
				return
			}
		}
	}

	private func obtainUsageData() -> SAP_Internal_Ppdd_PPADataIOS {

		let exposureRiskMetadata = gatherExposureRiskMetadata()
		// already created for EXPOSUREAPP-4790
		/*
		let newExposureWindows = gatherNewExposureWindows()
		*/

		let userMetadata = gatherUserMetadata()
		let clientMetadata = gatherClientMetadata()
		let keySubmissionMetadata = gatherKeySubmissionMetadata()
		let testResultMetadata = gatherTestResultMetadata()

		let payload = SAP_Internal_Ppdd_PPADataIOS.with {
			$0.exposureRiskMetadataSet = exposureRiskMetadata
			// already created for EXPOSUREAPP-4790
			/*
			$0.newExposureWindows = newExposureWindows
			*/
			$0.userMetadata = userMetadata
			$0.clientMetadata = clientMetadata
			$0.userMetadata = userMetadata
			
			if shouldIncludeKeySubmissionMetadata {
				$0.keySubmissionMetadataSet = keySubmissionMetadata
			}
			if shouldTestResultMetadataBeIncluded {
				$0.testResultMetadataSet = testResultMetadata
			}
		}

		return payload
	}

	private func submitData(with ppacToken: PPACToken, completion: ((Result<Void, PPASError>) -> Void)? = nil) {

		let payload = obtainUsageData()

		var forceApiTokenHeader = false
		#if !RELEASE
		forceApiTokenHeader = store.forceAPITokenAuthorization
		#endif

		client.submit(
			payload: payload,
			ppacToken: ppacToken,
			isFake: false,
			forceApiTokenHeader: forceApiTokenHeader,
			completion: { [weak self] result in
				switch result {
				case .success:
					Log.info("Analytics data succesfully submitted", log: .ppa)
					// after succesful submission, store the current risk exposure metadata as the previous one to get the next time a comparison.
					self?.store.previousRiskExposureMetadata = self?.store.currentRiskExposureMetadata
					self?.store.currentRiskExposureMetadata = nil
					self?.store.lastSubmittedPPAData = payload.textFormatString()
					completion?(result)
				case let .failure(error):
					Log.error("Analytics data were not submitted", log: .ppa, error: error)
					completion?(result)
				}
			}
		)
	}
	
	private func gatherExposureRiskMetadata() -> [SAP_Internal_Ppdd_ExposureRiskMetadata] {
		guard let storedUsageData = store.currentRiskExposureMetadata else {
			return []
		}
		return [SAP_Internal_Ppdd_ExposureRiskMetadata.with {
			$0.riskLevel = storedUsageData.riskLevel.protobuf
			$0.riskLevelChangedComparedToPreviousSubmission = storedUsageData.riskLevelChangedComparedToPreviousSubmission
			$0.mostRecentDateAtRiskLevel = formatToUnixTimestamp(for: storedUsageData.mostRecentDateAtRiskLevel)
			$0.dateChangedComparedToPreviousSubmission = storedUsageData.dateChangedComparedToPreviousSubmission
		}]
	}

	// already created for EXPOSUREAPP-4790
	/*
	private func gatherNewExposureWindows() -> [SAP_Internal_Ppdd_PPANewExposureWindow] {
	}
	*/

	private func gatherUserMetadata() -> SAP_Internal_Ppdd_PPAUserMetadata {
		guard let storedUserData = store.userMetadata else {
			return SAP_Internal_Ppdd_PPAUserMetadata.with { _ in }
		}

		return SAP_Internal_Ppdd_PPAUserMetadata.with {
			if let federalState = storedUserData.federalState {
				$0.federalState = federalState.protobuf
			}
			if let administrativeUnit = storedUserData.administrativeUnit {
				$0.administrativeUnit = Int32(administrativeUnit)
			}
			if let ageGroup = storedUserData.ageGroup {
				$0.ageGroup = ageGroup.protobuf
			}
		}
	}
	
	private func gatherClientMetadata() -> SAP_Internal_Ppdd_PPAClientMetadataIOS {
		guard let clientData = store.clientMetadata else {
			return SAP_Internal_Ppdd_PPAClientMetadataIOS.with { _ in }
		}
		
		return SAP_Internal_Ppdd_PPAClientMetadataIOS.with {
			if let cwaVersion = clientData.cwaVersion {
				$0.cwaVersion = cwaVersion.protobuf
			}
			if let eTag = clientData.eTag {
				$0.appConfigEtag = eTag
			}
			$0.iosVersion = clientData.iosVersion.protobuf
		}
	}
	
	// swiftlint:disable:next cyclomatic_complexity
	private func gatherKeySubmissionMetadata() -> [SAP_Internal_Ppdd_PPAKeySubmissionMetadata] {
		guard let storedUsageData = store.keySubmissionMetadata else {
			return []
		}
		return [SAP_Internal_Ppdd_PPAKeySubmissionMetadata.with {
			if let submitted = storedUsageData.submitted {
				$0.submitted = submitted
			}
			if let submittedInBackground = storedUsageData.submittedInBackground {
				$0.submittedInBackground = submittedInBackground
			}
			if let submittedAfterCancel = storedUsageData.submittedAfterCancel {
				$0.submittedAfterCancel = submittedAfterCancel
			}
			if let submittedAfterSymptomFlow = storedUsageData.submittedAfterSymptomFlow {
				$0.submittedAfterSymptomFlow = submittedAfterSymptomFlow
			}
			if let advancedConsentGiven = storedUsageData.advancedConsentGiven {
				$0.advancedConsentGiven = advancedConsentGiven
			}
			if let lastSubmissionFlowScreen = storedUsageData.lastSubmissionFlowScreen?.protobuf {
				$0.lastSubmissionFlowScreen = lastSubmissionFlowScreen
			}
			if let hoursSinceTestResult = storedUsageData.hoursSinceTestResult {
				$0.hoursSinceTestResult = hoursSinceTestResult
			}
			if let hoursSinceTestRegistration = storedUsageData.hoursSinceTestRegistration {
				$0.hoursSinceTestRegistration = hoursSinceTestRegistration
			}
			if let daysSinceMostRecentDateAtRiskLevelAtTestRegistration = storedUsageData.daysSinceMostRecentDateAtRiskLevelAtTestRegistration {
				$0.daysSinceMostRecentDateAtRiskLevelAtTestRegistration = daysSinceMostRecentDateAtRiskLevelAtTestRegistration
			}
			if let hoursSinceHighRiskWarningAtTestRegistration = storedUsageData.hoursSinceHighRiskWarningAtTestRegistration {
				$0.hoursSinceHighRiskWarningAtTestRegistration = hoursSinceHighRiskWarningAtTestRegistration
			}
			if let submittedWithTeleTAN = storedUsageData.submittedWithTeleTAN {
				$0.submittedWithTeleTan = submittedWithTeleTAN
			}
		}]
	}

	private func gatherTestResultMetadata() -> [SAP_Internal_Ppdd_PPATestResultMetadata] {
		let metadata = store.testResultMetadata

		let resultProtobuf = SAP_Internal_Ppdd_PPATestResultMetadata.with {
			
			if let testResult = metadata?.testResult?.protobuf {
				$0.testResult = testResult
			}
			if let hoursSinceTestRegistration = metadata?.daysSinceMostRecentDateAtRiskLevelAtTestRegistration {
				$0.hoursSinceTestRegistration = Int32(hoursSinceTestRegistration)
			}
			if let riskLevel = metadata?.riskLevelAtTestRegistration?.protobuf {
				$0.riskLevelAtTestRegistration = riskLevel
			}
			if let daysSinceMostRecentDateAtRiskLevelAtTestRegistration = metadata?.daysSinceMostRecentDateAtRiskLevelAtTestRegistration {
				$0.daysSinceMostRecentDateAtRiskLevelAtTestRegistration = Int32(daysSinceMostRecentDateAtRiskLevelAtTestRegistration)
			}
			if let hoursSinceHighRiskWarningAtTestRegistration = metadata?.hoursSinceHighRiskWarningAtTestRegistration {
				$0.hoursSinceHighRiskWarningAtTestRegistration = Int32(hoursSinceHighRiskWarningAtTestRegistration)
			}
		}
		return [resultProtobuf]
	}

	private func formatToUnixTimestamp(for date: Date?) -> Int64 {
		guard let date = date else {
			Log.warning("mostRecentDate is nil", log: .ppa)
			return -1
		}
		return Int64(date.timeIntervalSince1970)
	}
}
