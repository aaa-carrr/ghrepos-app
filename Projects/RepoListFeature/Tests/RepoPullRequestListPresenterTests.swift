import XCTest
import SnapshotTesting
import RxSwift
import Reducers
import Interactors
import Models
@testable import RepoListFeature

final class RepoPullRequestListPresenterTests: XCTestCase {
    var sut: RepoPullRequestListPresenter!
    var interactorMock: RepoPullRequestListInteractorTypeMock!
    var delegateMock: RepoPullRequestListPresenterDelegateMock!

    override func setUp() {
        super.setUp()
        let state = RepoPullRequestListStateModel(
            repoAuthor: "",
            repoName: "",
            currentPage: 0,
            canFetchNewPage: true,
            pullRequests: []
        )

        interactorMock = RepoPullRequestListInteractorTypeMock()

        sut = RepoPullRequestListPresenter(
            state: state,
            reducer: RepoPullRequestListReducer(),
            interactor: interactorMock,
            scheduler: MainScheduler.instance
        )

        delegateMock = RepoPullRequestListPresenterDelegateMock()

        sut.delegate = delegateMock
    }

    override func tearDown() {
        super.tearDown()
        interactorMock = nil
        sut = nil
        delegateMock = nil
    }

    func testRepoPullRequestListPresenter_setUp() {
        sut.setUp()
        XCTAssertTrue(delegateMock.didShowController)
    }
}

// MARK: - Mocks
final class RepoPullRequestListPresenterDelegateMock: RepoPullRequestListPresenterDelegate {
    private(set) var didShowController: Bool = false

    func show(_ controller: UIViewController) {
        didShowController = true
    }

    func show(pullRequest url: String) {
    }

}

final class RepoPullRequestListInteractorTypeMock: RepoPullRequestListInteractorType {
    func pullRequestList(from resource: RepoPullRequestListResource) -> Single<[RepoPullRequest]> {
        return Single<[RepoPullRequest]>.just([])
    }

    func authorProfileImage(from url: String) -> Single<UIImage> {
        return Single.just(UIImage())
    }
}
