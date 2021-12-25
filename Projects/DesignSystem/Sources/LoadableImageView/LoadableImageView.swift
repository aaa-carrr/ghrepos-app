import UIKit
import RxSwift
import RxCocoa

public final class LoadableImageView: UIImageView {
    private var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        contentMode = .scaleAspectFill
    }
    
    func setUp(with loadableImage: LoadableImage) {
        loadableImage
            .image
            .drive(rx.image)
            .disposed(by: disposeBag)
    }
}
