import XCTest
import RxSwift
import SnapshotTesting
@testable import DesignSystem

final class UserProfileCompactViewTests: XCTestCase {
    var sut: UserProfileCompactView!
    
    override func setUp() {
        super.setUp()
        sut = UserProfileCompactView()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testUserProfileCompactView_when_itIsSetUp() {
        let loadableImage = LoadableImage(
            single: Single<UIImage>.create { single in
                single(
                    .success(
                        UIImage(systemName: "person.circle") ?? UIImage()
                    )
                )
                return Disposables.create { }
            },
            defaultImage: UIImage()
        )
        let viewModel = UserProfileCompactViewModel(
            username: "Username",
            profileImage: loadableImage
        )
        
        sut.update(with: viewModel)
        
        let size = CGSize(
            width: 80,
            height: 80
        )
        
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testUserProfileCompactView_when_itIsSetUp_butImageFailsToLoad() {
        let loadableImage = LoadableImage(
            single: Single<UIImage>.create { single in
                single(.failure(NSError()))
                return Disposables.create { }
            },
            defaultImage: UIImage(systemName: "person.circle.fill") ?? UIImage()
        )
        let viewModel = UserProfileCompactViewModel(
            username: "Username",
            profileImage: loadableImage
        )
        
        sut.update(with: viewModel)
        
        let size = CGSize(
            width: 80,
            height: 80
        )
        
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testUserProfileCompactView_when_itIsSetUp_withAnEmptyString() {
        let loadableImage = LoadableImage(
            single: Single<UIImage>.create { single in
                single(
                    .success(
                        UIImage(systemName: "person.circle") ?? UIImage()
                    )
                )
                return Disposables.create { }
            },
            defaultImage: UIImage()
        )
        let viewModel = UserProfileCompactViewModel(
            username: "",
            profileImage: loadableImage
        )
        
        sut.update(with: viewModel)
        
        let size = CGSize(
            width: 80,
            height: 80
        )
        
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testUserProfileCompactView_when_itIsSetUp_withAVeryLongString() {
        let loadableImage = LoadableImage(
            single: Single<UIImage>.create { single in
                single(
                    .success(
                        UIImage(systemName: "person.circle") ?? UIImage()
                    )
                )
                return Disposables.create { }
            },
            defaultImage: UIImage()
        )
        let viewModel = UserProfileCompactViewModel(
            username: "Username is a very long long long string with multiple words!",
            profileImage: loadableImage
        )
        
        sut.update(with: viewModel)
        
        let size = CGSize(
            width: 80,
            height: 80
        )
        
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
