import UIKit
import RxSwift
import RxCocoa

final class LoadableImageView: UIImageView {
    private var disposeBag: DisposeBag = DisposeBag()
    
    func setUp(with loadableImage: LoadableImage) {
        disposeBag = DisposeBag()
        
        loadableImage
            .image
            .drive(rx.image)
            .disposed(by: disposeBag)
    }
}
