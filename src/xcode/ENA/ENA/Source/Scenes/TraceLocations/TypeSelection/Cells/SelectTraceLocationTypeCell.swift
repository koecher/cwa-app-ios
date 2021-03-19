////
// 🦠 Corona-Warn-App
//

import UIKit

class SelectTraceLocationTypeCell: UITableViewCell, ReuseIdentifierProviding {

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Overrides

	// MARK: - Public

	// MARK: - Internal

	func configure(cellModel: TraceLocationType) {
		titleLabel.text = cellModel.title
		subTitleLabel.text = cellModel.subtitle
	}

	// MARK: - Private#

	private let titleLabel = ENALabel()
	private let subTitleLabel = ENALabel()

	private func setupView() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.font = .enaFont(for: .body)
		titleLabel.textColor = .enaColor(for: .textPrimary1)

		subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		subTitleLabel.font = .enaFont(for: .subheadline)
		subTitleLabel.textColor = .enaColor(for: .textSemanticGray)

		let stackView = UIStackView(arrangedSubviews: [
			titleLabel,
			subTitleLabel
		])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 4.0
		contentView.addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23.0),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17.0),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
		])
	}


}
