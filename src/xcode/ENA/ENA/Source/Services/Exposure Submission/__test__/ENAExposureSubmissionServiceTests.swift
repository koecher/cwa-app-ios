////
// 🦠 Corona-Warn-App
//

import XCTest
@testable import ENA

class ENAExposureSubmissionServiceTests: XCTestCase {
	
	func test_When_SubmissionWasSuccessful_Then_CheckinSubmittedIsTrue() {
		let keysRetrievalMock = MockDiagnosisKeysRetrieval(diagnosisKeysResult: (nil, nil) )
		let mockStore = MockTestStore()

		let eventStore = MockEventStore()
		eventStore.createCheckin(Checkin.mock())

		let coronaTestService = CoronaTestService(
			client: ClientMock(),
			store: mockStore
		)
		coronaTestService.pcrTest = PCRTest.mock(
			registrationToken: "regToken",
			positiveTestResultWasShown: true,
			isSubmissionConsentGiven: true
		)

		mockStore.submissionKeys = [SAP_External_Exposurenotification_TemporaryExposureKey()]
		mockStore.submissionCheckins = [eventStore.checkinsPublisher.value[0]]
		
		let checkinSubmissionService = ENAExposureSubmissionService(
			diagnosisKeysRetrieval: keysRetrievalMock,
			appConfigurationProvider: CachedAppConfigurationMock(),
			client: ClientMock(),
			store: mockStore,
			eventStore: eventStore,
			coronaTestService: coronaTestService
		)
		
		let completionExpectation = expectation(description: "Completion should be called.")
		checkinSubmissionService.submitExposure(coronaTestType: .pcr) { error in
			XCTAssertNil(error)
			XCTAssertTrue(eventStore.checkinsPublisher.value[0].checkinSubmitted)
			
			completionExpectation.fulfill()
		}
		
		waitForExpectations(timeout: .short)
	}

}
