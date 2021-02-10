////
// 🦠 Corona-Warn-App
//

import Foundation
import UIKit
import OpenCombine

final class DataDonationViewModel {

	// MARK: - Init

	init(
		store: Store,
		presentSelectValueList: @escaping (SelectValueViewModel) -> Void
	) {
		self.presentSelectValueList = presentSelectValueList
		self.reloadTableView = false
		self.dataDonationModel = DataDonationModel(store: store)
	}

	// MARK: - Overrides

	// MARK: - Protocol <#Name#>

	// MARK: - Public
	
	func setConsent(consentGiven: Bool) {
		dataDonationModel.isConsentGiven = consentGiven
		Log.debug("DataDonation consent value set to '\(consentGiven)'")
	}

	// MARK: - Internal

	// [KGA] add accessibilityLabel and identifier back to cell
	//	accessibilityLabel: AppStrings.NewVersionFeatures.accImageLabel,
	//	accessibilityIdentifier: AccessibilityIdentifiers.DeltaOnboarding.newVersionFeaturesAccImageDescription,

	@OpenCombine.Published private (set) var reloadTableView: Bool

	var dynamicTableViewModel: DynamicTableViewModel {
		/// create the top section with the illustration and title text
		var dynamicTableViewModel = DynamicTableViewModel.with {
			$0.add(
				.section(
					header: .image(
						UIImage(named: "Illu_DataDonation"),
						accessibilityLabel: "AppStrings.DataDonation.Info.accImageDescription",
						accessibilityIdentifier: "AccessibilityIdentifiers.DataDonation.accImageDescription",
						height: 250
					),
					cells: [
						.title1(text: AppStrings.DataDonation.Info.title, accessibilityIdentifier: "AppStrings.DataDonation.Info.title"),
						.headline(text: AppStrings.DataDonation.Info.description)
					]
				)
			)
		}

		/// section to show input fields with already given data
		/// this will change numer of cells by the already entered data
		let sectionCells: [DynamicCell] = [
			.headline(text: AppStrings.DataDonation.Info.subHeadState),

			.body(text: friendlyFederalStateName, style: .label, accessibilityTraits: .button, action: .execute(block: { [weak self] _, _ in
				self?.didTapSelectStateButton()
			}), configure: { _, cell, _ in
				cell.accessoryType = .disclosureIndicator
			}),
			dataDonationModel.federalStateName != nil ?
				.body(text: friendlyRegionName, style: .label, accessibilityIdentifier: nil, accessibilityTraits: .button, action: .execute(block: { [weak self] _, _ in
					self?.didTapSelectRegionButton()
				}), configure: { _, cell, _ in
					cell.accessoryType = .disclosureIndicator
				}) :
				nil,
			.headline(text: AppStrings.DataDonation.Info.subHeadAgeGroup),
			.body(text: friendlyAgeName, style: .label, color: nil, accessibilityIdentifier: nil, accessibilityTraits: .button, action: .execute(block: { [weak self] _, _ in
				self?.didTapAgeButton()
			}), configure: { _, cell, _ in
				cell.accessoryType = .disclosureIndicator
			})
		]
		.compactMap { $0 }

		dynamicTableViewModel.add(
			.section(
				cells: sectionCells
			)
		)

		/// section for the legal texts
		dynamicTableViewModel.add(
			.section(
				cells: [
					.legal(title: NSAttributedString(string: AppStrings.ExposureSubmissionQRInfo.acknowledgementTitle),
						   description: NSAttributedString(string: AppStrings.ExposureSubmissionQRInfo.acknowledgementBody),
						   textBlocks: [
							acknowledgementString,
							NSAttributedString(string: AppStrings.ExposureSubmissionWarnOthers.acknowledgement_footer)
						   ],
						   accessibilityIdentifier: AccessibilityIdentifiers.ExposureSubmissionQRInfo.acknowledgementTitle),
					.bulletPoint(text: AppStrings.ExposureSubmissionQRInfo.acknowledgement3, alignment: .legal),
					.bulletPoint(text: AppStrings.ExposureSubmissionQRInfo.acknowledgement5, alignment: .legal),
					.bulletPoint(text: AppStrings.ExposureSubmissionQRInfo.acknowledgement6, alignment: .legal),
					.space(height: 16)
				]
			)
		)
		
		// [AVO: TODO] - Show DataDonationDetails navigation
		dynamicTableViewModel.add(
			.section(separators: .all, cells: [
				.body(
					text: AppStrings.DataDonation.Info.dataProcessingDetails,
					style: DynamicCell.TextCellStyle.label,
					accessibilityIdentifier: AccessibilityIdentifiers.ExposureSubmissionQRInfo.dataProcessingDetailInfo,
					accessibilityTraits: UIAccessibilityTraits.link,
					action: .push(model: AppInformationModel.privacyModel,
								  withTitle: AppStrings.AppInformation.privacyTitle,
								  completion: nil
					),
					configure: { _, cell, _ in
						cell.accessoryType = .disclosureIndicator
						cell.selectionStyle = .default
					}),
				.space(height: 12)
			])
		)

		return dynamicTableViewModel
	}

	// MARK: - Private

	private let presentSelectValueList: (SelectValueViewModel) -> Void

	private var dataDonationModel: DataDonationModel
	private var subscriptions: [AnyCancellable] = []

	private var friendlyFederalStateName: String {
		return dataDonationModel.federalStateName ?? AppStrings.DataDonation.Info.noSelectionState
	}

	private var friendlyRegionName: String {
		return dataDonationModel.region ?? AppStrings.DataDonation.Info.noSelectionRegion
	}

	private var friendlyAgeName: String {
		return dataDonationModel.age ?? AppStrings.DataDonation.Info.noSelectionAgeGroup
	}

	private let acknowledgementString: NSAttributedString = {
		let boldText = AppStrings.ExposureSubmissionWarnOthers.acknowledgement_1_1
		let normalText = AppStrings.ExposureSubmissionWarnOthers.acknowledgement_1_2
		let string = NSMutableAttributedString(string: "\(boldText) \(normalText)")

		// highlighted text
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.preferredFont(forTextStyle: .headline)
		]
		string.addAttributes(attributes, range: NSRange(location: 0, length: boldText.count))

		return string
	}()

	private func didTapSelectStateButton() {
		let selectValueViewModel = SelectValueViewModel(
			dataDonationModel.allFederalStateNames,
			title: AppStrings.DataDonation.ValueSelection.Title.State,
			preselected: dataDonationModel.federalStateName
		)
		selectValueViewModel.$selectedValue.sink { [weak self] federalState in
			guard self?.dataDonationModel.federalStateName != federalState else {
				return
			}
			// if a new fedaral state got selected reset region as well
			self?.dataDonationModel.federalStateName = federalState
			self?.dataDonationModel.region = nil
			self?.reloadTableView.toggle()
		}.store(in: &subscriptions)
		presentSelectValueList(selectValueViewModel)
	}

	private func didTapSelectRegionButton() {
		guard let federalStateName = dataDonationModel.federalStateName else {
			Log.debug("Missing federal state to load regions", log: .ppac)
			return
		}

		let selectValueViewModel = SelectValueViewModel(
			dataDonationModel.allRegions(by: federalStateName),
			title: AppStrings.DataDonation.ValueSelection.Title.Region,
			preselected: dataDonationModel.region
		)
		selectValueViewModel.$selectedValue .sink { [weak self] region in
			guard self?.dataDonationModel.region != region else {
				return
			}
			self?.dataDonationModel.region = region
			self?.reloadTableView.toggle()
		}.store(in: &subscriptions)

		presentSelectValueList(selectValueViewModel)
	}

	private func didTapAgeButton() {
		let selectValueViewModel = SelectValueViewModel(
			AgeGroup.allCases.map({ $0.text }),
			title: AppStrings.DataDonation.ValueSelection.Title.Age,
			preselected: dataDonationModel.age
		)
		selectValueViewModel.$selectedValue .sink { [weak self] age in
			guard self?.dataDonationModel.age != age else {
				return
			}
			self?.dataDonationModel.age = age
			self?.reloadTableView.toggle()
		}.store(in: &subscriptions)

		presentSelectValueList(selectValueViewModel)
	}

}
