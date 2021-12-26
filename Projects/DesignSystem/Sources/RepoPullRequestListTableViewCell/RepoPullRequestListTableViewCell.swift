import UIKit

public final class RepoPullRequestListTableViewCell: UITableViewCell {
    // MARK: - Properties
    @AutoLayout private var cellContentView: RepoPullRequestListTableViewCellContentView

    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View configuration
    private func setUp() {
        contentView.addSubview(cellContentView)

        NSLayoutConstraint.activate(
            [
                cellContentView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                cellContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
                cellContentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                cellContentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
        )
    }

    // MARK: - API
    public func update(with viewModel: RepoPullRequestListTableViewCellViewModel) {
        cellContentView.update(with: viewModel)
    }
}
