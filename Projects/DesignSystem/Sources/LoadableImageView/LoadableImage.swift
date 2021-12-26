import UIKit
import RxSwift
import RxCocoa

public struct LoadableImage {
    private let single: Single<UIImage>
    public let defaultImage: UIImage
    
    public init(
        single: Single<UIImage>,
        defaultImage: UIImage
    ) {
        self.single = single
        self.defaultImage = defaultImage
    }
    
    public var image: Driver<UIImage> {
        return single.asDriver(onErrorJustReturn: defaultImage)
    }
}
