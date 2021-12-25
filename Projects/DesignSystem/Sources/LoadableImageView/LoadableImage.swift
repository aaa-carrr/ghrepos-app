import UIKit
import RxSwift
import RxCocoa

public struct LoadableImage {
    private let single: Single<UIImage>
    let defaultImage: UIImage
    
    init(
        single: Single<UIImage>,
        defaultImage: UIImage
    ) {
        self.single = single
        self.defaultImage = defaultImage
    }
    
    var image: Driver<UIImage> {
        return single.asDriver(onErrorJustReturn: defaultImage)
    }
}
