import UIKit

final class SnapshotViewController: UIViewController {
    let snapshotView: UIView
    let size: CGSize
    
    init(_ snapshotView: UIView, size: CGSize) {
        self.snapshotView = snapshotView
        self.size = size
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snapshotView)
        NSLayoutConstraint.activate(
            [
                snapshotView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                snapshotView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                snapshotView.widthAnchor.constraint(equalToConstant: size.width),
                snapshotView.heightAnchor.constraint(equalToConstant: size.height)
            ]
        )
    }
}
