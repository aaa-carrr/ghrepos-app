import UIKit

final class RepoPullRequestListTableViewCellContentView: UIView {
    // MARK: - Properties
    @AutoLayout private var contentStackView: UIStackView

    @AutoLayout private var pullRequestNameDescriptionContentView: UIView
    @AutoLayout private var pullRequestNameLabel: UILabel
    @AutoLayout private var pullRequestDescriptionLabel: UILabel
    @AutoLayout private var pullRequestDateOfCreationLabel: UILabel

    @AutoLayout private var repoAuthor: UserProfileCompactView

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Layout
    private func setUp() {
        backgroundColor = .systemBackground
        setUpViews()
        layoutViews()
        layoutConstraints()
    }

    private func layoutViews() {
        pullRequestNameDescriptionContentView.addSubview(pullRequestNameLabel)
        pullRequestNameDescriptionContentView.addSubview(pullRequestDescriptionLabel)
        pullRequestNameDescriptionContentView.addSubview(pullRequestDateOfCreationLabel)

        contentStackView.addArrangedSubview(pullRequestNameDescriptionContentView)
        contentStackView.addArrangedSubview(repoAuthor)

        addSubview(contentStackView)
    }

    // MARK: - View Configuration
    private func setUpViews() {
        setUpContentStackView()
        setUpRepoNameLabel()
        setUpRepoDescriptionLabel()
    }

    private func setUpContentStackView() {
        contentStackView.axis = .horizontal
        contentStackView.distribution = .fill
        contentStackView.alignment = .fill
        contentStackView.spacing = 12
    }

    private func setUpRepoNameLabel() {
        pullRequestNameLabel.textColor = .label
        pullRequestNameLabel.font = .preferredFont(forTextStyle: .headline)
        pullRequestNameLabel.numberOfLines = 2
    }

    private func setUpRepoDescriptionLabel() {
        pullRequestDescriptionLabel.textColor = .secondaryLabel
        pullRequestDescriptionLabel.font = .preferredFont(forTextStyle: .body)
        pullRequestDescriptionLabel.numberOfLines = 4
    }

    // MARK: - Constraints
    private func layoutConstraints() {
        NSLayoutConstraint.activate(
            [
                contentStackView.topAnchor.constraint(equalTo: topAnchor),
                contentStackView.widthAnchor.constraint(equalTo: widthAnchor),
                contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ]
        )

        NSLayoutConstraint.activate(
            [
                repoAuthor.topAnchor.constraint(equalTo: topAnchor),
                repoAuthor.bottomAnchor.constraint(equalTo: bottomAnchor),
                repoAuthor.widthAnchor.constraint(equalToConstant: 80)
            ]
        )

        NSLayoutConstraint.activate(
            [
                pullRequestNameLabel.topAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.topAnchor),
                pullRequestNameLabel.leadingAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.leadingAnchor),
                pullRequestNameLabel.trailingAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.trailingAnchor),
                pullRequestNameLabel.heightAnchor.constraint(equalToConstant: 20)
            ]
        )

        NSLayoutConstraint.activate(
            [
                pullRequestDescriptionLabel.topAnchor.constraint(equalTo: pullRequestNameLabel.bottomAnchor, constant: 4),
                pullRequestDescriptionLabel.leadingAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.leadingAnchor),
                pullRequestDescriptionLabel.trailingAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.trailingAnchor),
                pullRequestDescriptionLabel.heightAnchor.constraint(equalToConstant: 80)
            ]
        )

        NSLayoutConstraint.activate(
            [
                pullRequestDateOfCreationLabel.topAnchor.constraint(equalTo: pullRequestDescriptionLabel.bottomAnchor, constant: 4),
                pullRequestDateOfCreationLabel.leadingAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.leadingAnchor),
                pullRequestDateOfCreationLabel.trailingAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.trailingAnchor),
                pullRequestDateOfCreationLabel.bottomAnchor.constraint(equalTo: pullRequestNameDescriptionContentView.bottomAnchor)
            ]
        )

        NSLayoutConstraint.activate(
            [
                pullRequestNameDescriptionContentView.heightAnchor.constraint(equalToConstant: 125)
            ]
        )
    }

    // MARK: - API
    func update(with viewModel: RepoPullRequestListTableViewCellViewModel) {
        pullRequestNameLabel.text = viewModel.pullRequestTitle
        pullRequestDescriptionLabel.text = viewModel.pullRequestBody
        pullRequestDateOfCreationLabel.text = viewModel.pullRequestDateOfCreation
        repoAuthor.update(with: viewModel.pullRequestAuthor)
    }
}
