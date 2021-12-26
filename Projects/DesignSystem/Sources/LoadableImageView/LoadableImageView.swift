import UIKit
import RxSwift
import RxCocoa

public final class LoadableImageView: UIImageView {
    // MARK: - Properties
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setUp() {
        contentMode = .scaleAspectFit
    }
    
    // MARK: - API
    public func setUp(with loadableImage: LoadableImage) {
        image = nil
        loadableImage
            .image
            .drive(rx.image)
            .disposed(by: disposeBag)
    }
}
