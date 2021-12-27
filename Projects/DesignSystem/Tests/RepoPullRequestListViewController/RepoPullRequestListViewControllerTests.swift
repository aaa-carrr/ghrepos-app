import XCTest
import RxSwift
import RxTest
import SnapshotTesting
@testable import DesignSystem

final class RepoPullRequestListViewControllerTests: XCTestCase {
    var scheduler: TestScheduler!
    var reposTableView: RepoPullRequestListTableView!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        reposTableView = RepoPullRequestListTableView(scheduler: scheduler)
    }

    override func tearDown() {
        super.tearDown()
        scheduler = nil
    }

    func testRepoPullRequestListViewController_when_itIs_inState_show() {
        let stateObservable: Observable<RepoPullRequestListViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .show(makeViewModel()))
            ]
        ).asObservable()

        let sut = RepoPullRequestListViewController(
            repoListView: reposTableView,
            state: stateObservable.asObservable(),
            scheduler: scheduler
        )

        _ = sut.view

        scheduler.advanceTo(10)

        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }

    func testRepoPullRequestListViewController_when_itIs_inState_loading() throws {
        let stateObservable: Observable<RepoPullRequestListViewControllerState> = scheduler.createColdObservable(
            [
                .next(5, .loading)
            ]
        ).asObservable()

        let sut = RepoPullRequestListViewController(
            repoListView: reposTableView,
            state: stateObservable.asObservable(),
            scheduler: scheduler
        )

        _ = sut.view

        var didShowLoading: Bool = false

        sut.onFeedbackShow = {
            didShowLoading = true
        }

        scheduler.advanceTo(50)

        XCTAssertTrue(didShowLoading)
    }

    func testRepoPullRequestListViewController_when_itIs_inState_error() throws {
        let stateObservable: Observable<RepoPullRequestListViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .error)
            ]
        ).asObservable()

        let sut = RepoPullRequestListViewController(
            repoListView: reposTableView,
            state: stateObservable.asObservable(),
            scheduler: scheduler
        )

        _ = sut.view

        var didShowError: Bool = false

        sut.onFeedbackShow = {
            didShowError = true
        }

        scheduler.advanceTo(50)

        XCTAssertTrue(didShowError)
    }

    func testRepoPullRequestListViewController_when_itTriggers_tappedPullRequest() throws {
        let stateObservable: Observable<RepoPullRequestListViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .show(makeViewModel()))
            ]
        ).asObservable()

        let sut = RepoPullRequestListViewController(
            repoListView: reposTableView,
            state: stateObservable.asObservable(),
            scheduler: scheduler
        )

        _ = sut.view

        scheduler.advanceTo(10)

        var didTapIndex: IndexPath?

        sut.onAction = { action in
            if case .tappedPullRequest(atIndex: let index) = action {
                didTapIndex = index
            }
        }

        reposTableView.delegate?.tableView?(reposTableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        scheduler.advanceTo(40)

        let tappedIndex = try XCTUnwrap(didTapIndex)
        XCTAssertEqual(tappedIndex, IndexPath(row: 0, section: 0))
    }

    func testRepoPullRequestListViewController_when_itTriggers_fetchedAction_whenItLoads() {
        let stateObservable: Observable<RepoPullRequestListViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .show(makeViewModel()))
            ]
        ).asObservable()

        let sut = RepoPullRequestListViewController(
            repoListView: reposTableView,
            state: stateObservable.asObservable(),
            scheduler: scheduler
        )

        var didCallFetch: Bool = false

        sut.onAction = { action in
            if case .fetched = action {
                didCallFetch = true
            }
        }

        _ = sut.view

        scheduler.advanceTo(10)

        XCTAssertTrue(didCallFetch)
    }

    func makeViewModel() -> RepoPullRequestListTableViewModel {
        let ids: [Int] = [0, 1, 2, 3, 4, 5, 6]
        var cells: [RepoPullRequestListTableViewCellViewModel] = []
        ids.forEach { id in
            let author = UserProfileCompactViewModel(
                username: "aaa-carrr",
                profileImage: LoadableImage(
                    single: Single<UIImage>.just(UIImage(systemName: "person.circle.fill") ?? UIImage()),
                    defaultImage: UIImage()
                )
            )
            let cell = RepoPullRequestListTableViewCellViewModel(
                id: id,
                pullRequestTitle: "Pull Request",
                pullRequestBody: "Something new!!!",
                pullRequestAuthor: author,
                pullRequestDateOfCreation: "2021-12-26"
            )
            cells.append(cell)
        }
        let section = RepoPullRequestListTableViewSection(section: 0)
        let viewModel = RepoPullRequestListTableViewModel(
            section: section,
            cells: cells
        )
        return viewModel
    }
}
