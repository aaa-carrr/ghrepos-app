import XCTest
import RxSwift
import SnapshotTesting
@testable import DesignSystem

final class LoadableImageViewTests: XCTestCase {
    var sut: LoadableImageView!
    
    override func setUp() {
        super.setUp()
        sut = LoadableImageView(frame: .zero)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testLoadableImageView_when_itLoadsAnImage() {
        let single = Single<UIImage>.create { single in
            let image = UIImage(systemName: "person.circle")
            if let image = image {
                single(.success(image))
            } else {
                single(.failure(NSError()))
            }
            return Disposables.create {}
        }
        
        let loadableImage = LoadableImage(
            single: single,
            defaultImage: UIImage()
        )
        
        sut.tintColor = .red
        sut.setUp(with: loadableImage)
        
        let size = CGSize(
            width: 50,
            height: 50
        )
        
        assertSnapshot(matching: sut, as: .image(size: size))

    }
    
    func testLoadableImageView_when_itFailsToLoadAnImage() {
        let single = Single<UIImage>.create { single in
            single(.failure(NSError()))
            return Disposables.create {}
        }
        
        let loadableImage = LoadableImage(
            single: single,
            defaultImage:  UIImage(systemName: "person.circle.fill") ?? UIImage()
        )
        
        sut.tintColor = .red
        sut.setUp(with: loadableImage)
        
        let size = CGSize(
            width: 50,
            height: 50
        )
        
        assertSnapshot(matching: sut, as: .image(size: size))

    }
}
