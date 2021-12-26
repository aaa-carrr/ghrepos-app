import UIKit

final class FeedbackScreenViewController: UIViewController {
    // MARK: - Properties
    @AutoLayout private var messageLabel: UILabel
    @AutoLayout private var messageIcon: UIImageView
    @AutoLayout private var messageStackView: UIStackView
    @AutoLayout private var actionButton: UIButton

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.backgroundColor = .systemBackground
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: - View Configuration
    private func setUp() {
        view.backgroundColor = .systemBackground
        layoutViews()
        layoutConstraints()
        setUpLoadingIndicator()
        setUpMessageLabel()
        setUpMessageIcon()
        setUpMessageStack()
        setUpActionButton()
        addAction()
    }
    
    private func layoutViews() {
        messageStackView.addArrangedSubview(messageIcon)
        messageStackView.addArrangedSubview(messageLabel)
        messageStackView.addArrangedSubview(actionButton)
        view.addSubview(messageStackView)
    }

    private func layoutConstraints() {
        NSLayoutConstraint.activate(
            [
                messageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                messageStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                messageStackView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
                messageStackView.heightAnchor.constraint(equalToConstant: 200)
            ]
        )

        NSLayoutConstraint.activate(
            [
                actionButton.heightAnchor.constraint(equalToConstant: 50),
                actionButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor)
            ]
        )
    }

    private func setUpLoadingIndicator() {
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate(
            [
                loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loadingIndicator.widthAnchor.constraint(equalTo: view.widthAnchor),
                loadingIndicator.heightAnchor.constraint(equalTo: view.heightAnchor)
            ]
        )
    }

    private func setUpMessageLabel() {
        messageLabel.numberOfLines = 5
        messageLabel.font = .preferredFont(forTextStyle: .body)
        messageLabel.textColor = .label
    }

    private func setUpMessageIcon() {
        messageIcon.contentMode = .scaleAspectFill
    }

    private func setUpActionButton() {
        actionButton.backgroundColor = .systemGray6
        actionButton.setTitleColor(.label, for: .normal)
        actionButton.layer.cornerRadius = 15
        actionButton.clipsToBounds = true
    }

    private func setUpMessageStack() {
        messageStackView.axis = .vertical
        messageStackView.distribution = .fill
        messageStackView.alignment = .center
        messageStackView.spacing = 16
    }

    // MARK: - Button Action
    private func addAction() {
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }

    @objc
    private func didTapActionButton() {
        after?(
            onAction?() ?? .dismiss
        )
    }

    // MARK: - API
    var onAction: (() -> FeedbackScreenAfter)?
    var after: ((FeedbackScreenAfter) -> Void)?

    func setUp(with viewModel: FeedbackScreenViewModel) {
        switch viewModel {
        case .error:
            messageLabel.text = viewModel.message
            messageIcon.tintColor = viewModel.iconColor
            messageIcon.image = viewModel.icon
            actionButton.setTitle(viewModel.action, for: .normal)
        case .loading:
            loadingIndicator.startAnimating()
        }
    }
}
