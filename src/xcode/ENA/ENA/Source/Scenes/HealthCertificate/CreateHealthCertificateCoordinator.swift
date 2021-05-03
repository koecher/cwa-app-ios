////
// 🦠 Corona-Warn-App
//

import UIKit

final class CreateHealthCertificateCoordinator {

	// MARK: - Init

	init(
		parentViewController: UIViewController
	) {
		self.parentViewController = parentViewController
		self.coordinatorViewModel = CreateHealthCertificateCoordinatorViewModel()
		self.navigationController = UINavigationController()
	}

	// MARK: - Overrides

	// MARK: - Protocol <#Name#>

	// MARK: - Public

	// MARK: - Internal

	func start() {
		if !coordinatorViewModel.hasShownConsetScreem {
			showConsetScreem()
		} else {
			showQRCodeScanner()
		}
	}

	func endCoordinator() {
		parentViewController.dismiss(animated: true)
	}

	// MARK: - Private

	private let parentViewController: UIViewController
	private let coordinatorViewModel: CreateHealthCertificateCoordinatorViewModel
	private let navigationController: UINavigationController

	private func showConsetScreem() {
		let consetScreen = HealthCertificateConsentViewController(
			didTapConsetButton: showQRCodeScanner,
			dismiss: endCoordinator
		)

		let footerViewController = FooterViewController(
			FooterViewModel(
				primaryButtonName: "Einverstanden",
				isPrimaryButtonEnabled: true,
				isSecondaryButtonEnabled: false,
				isSecondaryButtonHidden: true,
				backgroundColor: .enaColor(for: .background)
			)
		)

		let topBottomContainerViewController = TopBottomContainerViewController(
			topController: consetScreen,
			bottomController: footerViewController
		)

		// we do not animate here because this alwasy is the first screen
		navigationController.pushViewController(topBottomContainerViewController, animated: false)
		parentViewController.present(navigationController, animated: true)
	}

	private func showQRCodeScanner() {
		let qrCodeScannerViewController = HealthCertificateQRCodeScannerViewController(
			didScanCertificate: { payload in
				// get healthCertificatePerson from sercvice here
				self.showHealthCertificatePerson(payload, animated: false)
				self.navigationController.dismiss(animated: true)
			}, dismiss: {
				self.endCoordinator()
			}
		)

		let qrCodeNavigationControler = UINavigationController(rootViewController: qrCodeScannerViewController)
		navigationController.present(qrCodeNavigationControler, animated: true)
	}

	// healthCertificatePerson is a string for the moment
	private func showHealthCertificatePerson(_ healthCertificatePerson: String, animated: Bool) {
		let consetScreen = HealthCertificatePersonViewController(
			healthCertificatePerson: healthCertificatePerson,
			dismiss: {
				self.endCoordinator()
			},
			didTapHealthCertificate: {
				Log.debug("didTapHealthCertificate")
			},
			didTapRegisterAnotherHealthCertificate: {
				self.showQRCodeScanner()
			}
		)

		let footerViewController = FooterViewController(
			FooterViewModel(
				primaryButtonName: "Weitere Impfung registrieren",
				isPrimaryButtonEnabled: true,
				isSecondaryButtonEnabled: false,
				isSecondaryButtonHidden: true,
				backgroundColor: .enaColor(for: .background)
			)
		)

		let topBottomContainerViewController = TopBottomContainerViewController(
			topController: consetScreen,
			bottomController: footerViewController
		)

		navigationController.pushViewController(topBottomContainerViewController, animated: animated)
	}

	// healthCertificate is a string for the moment
	private func showHealthCertificate(_ healthCertificate: String) {
//		let consetScreen = HealthCertificatePersonViewController(
//			healthCertificatePerson: healthCertificate,
//			dismiss: {
//				self.parentViewController.dismiss(animated: true)
//			},
//			didTapHealtCertificate: {
//				Log.debug("didTapHealtCertificate")
//			},
//			didTapRegisterHealtCertificate: <#T##() -> Void#>)
//
//		let footerViewController = FooterViewController(
//			FooterViewModel(
//				primaryButtonName: "Weitere Impfung registrieren",
//				isPrimaryButtonEnabled: true,
//				isSecondaryButtonEnabled: false,
//				isSecondaryButtonHidden: true,
//				backgroundColor: .enaColor(for: .background)
//			)
//		)
//
//		let topBottomContainerViewController = TopBottomContainerViewController(
//			topController: consetScreen,
//			bottomController: footerViewController
//		)
//
//		navigationController.pushViewController(topBottomContainerViewController, animated: true)
	}

}
