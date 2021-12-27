import XCTest
import SnapshotTesting
import RxSwift
import Reducers
import Interactors
import Models
@testable import RepoListFeature

final class RepoListPresenterTests: XCTestCase {
    var sut: RepoListPresenter!
    var interactorMock: RepoListInteractorTypeMock!
    var delegateMock: RepoListPresenterDelegateMock!

    override func setUp() {
        super.setUp()
        let state = RepoListStateModel(
            currentPage: 0,
            lastFetchedPage: 0,
            isFetching: false,
            numberOfPages: 0,
            repos: []
        )

        interactorMock = RepoListInteractorTypeMock()

        sut = RepoListPresenter(
            state: state,
            reducer: RepoListReducer(),
            interactor: interactorMock,
            scheduler: MainScheduler.instance
        )

        delegateMock = RepoListPresenterDelegateMock()

        sut.delegate = delegateMock
    }

    override func tearDown() {
        super.tearDown()
        interactorMock = nil
        sut = nil
        delegateMock = nil
    }

    func testRepoListPresenter_setUp() {
        sut.setUp()
        XCTAssertTrue(delegateMock.didShowController)
    }
}

// MARK: - Mocks
final class RepoListPresenterDelegateMock: RepoListPresenterDelegate {
    private(set) var didShowController: Bool = false
    private(set) var didShowRepoStateModel: RepoStateModel?

    func show(_ controller: UIViewController) {
        didShowController = true
    }

    func show(repo: RepoStateModel) {
        didShowRepoStateModel = repo
    }
}

final class RepoListInteractorTypeMock: RepoListInteractorType {
    func repoList(from resource: RepoListInteractorResource) -> Single<RepoList> {
        return Single<RepoList>.just(
            RepoList(totalCount: 0, items: [])
        )
    }

    func authorProfileImage(from url: String) -> Single<UIImage> {
        return Single.just(UIImage())
    }
}
