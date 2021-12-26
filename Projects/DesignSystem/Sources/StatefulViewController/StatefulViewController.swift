import UIKit

open class StatefulViewController: UIViewController {
    fileprivate let feedbackView: FeedbackScreenViewController = FeedbackScreenViewController()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setUpFeedbackView()
    }

    private func setUpFeedbackView() {
        feedbackView.after = { [weak self] action in
            switch action {
            case .dismiss:
                self?.feedbackView.dismiss(animated: true)
            }
        }

        onFeedbackShow = { [weak self] in
            guard let self = self else { return }
            self.present(
                self.feedbackView,
                animated: true
            )
        }

        onFeedbackDismiss = { [weak self] in
            self?.feedbackView.dismiss(animated: true)
        }
    }

    func showFeedback(
        _ viewModel: FeedbackScreenViewModel,
        onAction: (() -> FeedbackScreenAfter)? = nil
    ) {
        feedbackView.modalTransitionStyle = .crossDissolve
        feedbackView.modalPresentationStyle = .fullScreen
        onFeedbackShow?()
        feedbackView.setUp(with: viewModel)
        feedbackView.onAction = onAction
    }

    func dismissFeedback() {
        onFeedbackDismiss?()
    }

    var onFeedbackShow: (() -> Void)?
    var onFeedbackDismiss: (() -> Void)?
}
