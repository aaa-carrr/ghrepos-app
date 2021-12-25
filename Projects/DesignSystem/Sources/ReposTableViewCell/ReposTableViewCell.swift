import UIKit

public final class ReposTableViewCell: UITableViewCell {
    // MARK: - Properties
    @AutoLayout private var cellContentView: ReposTableViewCellContentView
    
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
                cellContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                cellContentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                cellContentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
        )
    }
    
    // MARK: - API
    public func update(with viewModel: ReposTableViewCellViewModel) {
        cellContentView.update(with: viewModel)
    }
}
