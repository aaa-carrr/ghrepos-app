import UIKit
import WebKit

public final class RepoPullRequestWebViewController: UIViewController {
    private let webView: WKWebView
    private let url: String

    public init(
        webView: WKWebView = WKWebView(frame: .zero),
        url: String
    ) {
        self.webView = webView
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        view = webView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        guard let safeUrl = URL(string: url) else { return }
        let request = URLRequest(url: safeUrl)
        webView.load(request)
    }
}

extension RepoPullRequestWebViewController: WKUIDelegate {

}
