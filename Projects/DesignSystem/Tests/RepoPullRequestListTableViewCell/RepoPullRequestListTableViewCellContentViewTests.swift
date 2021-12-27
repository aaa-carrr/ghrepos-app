import XCTest
import RxSwift
import SnapshotTesting
@testable import DesignSystem

final class RepoPullRequestListTableViewCellContentViewTests: XCTestCase {
    var sut: RepoPullRequestListTableViewCellContentView!

    override func setUp() {
        super.setUp()
        sut = RepoPullRequestListTableViewCellContentView(frame: .zero)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testRepoPullRequestListTableViewCell_when_itIsUpdated() {
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

        let viewModel = RepoPullRequestListTableViewCellViewModel(
            id: 0,
            pullRequestTitle: "Pull Request",
            pullRequestBody: "Something new!!!",
            pullRequestAuthor: repoAuthor,
            pullRequestDateOfCreation: "2021-12-26"
        )

        sut.update(with: viewModel)

        let size = CGSize(
            width: 350,
            height: 130
        )

        assertSnapshot(matching: sut, as: .image(size: size))
    }
}

