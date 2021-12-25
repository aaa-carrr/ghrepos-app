import XCTest
import RxSwift
import SnapshotTesting
@testable import DesignSystem

final class ReposTableViewCellTests: XCTestCase {
    var sut: ReposTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = ReposTableViewCell(frame: .zero)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testReposTableViewCell_when_itIsUpdated() {
        let loadableImage = LoadableImage(
            single: Single<UIImage>.create { single in
                single(
                    .success(
                        UIImage(systemName: "person.circle.fill") ?? UIImage()
                    )
                )
                return Disposables.create { }
            },
            defaultImage: UIImage()
        )
        
        let repoAuthor = UserProfileCompactViewModel(
            username: "aaa-carrr",
            profileImage: loadableImage
        )
        
        let viewModel = ReposTableViewCellViewModel(
            repoName: "Repository",
            repoDescription: "Repo description with some text to describe what it does. Repo description with some text to describe what it does. Repo description with some text to describe what it does. Repo description with some text to describe what it does",
            repoAuthor: repoAuthor,
            repoStars: "34 stars",
            repoForks: "6 forks"
        )
        
        sut.update(with: viewModel)
        
        let size = CGSize(
            width: 350,
            height: 110
        )
        
        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
