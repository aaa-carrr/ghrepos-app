import XCTest
import RxSwift
import RxTest
import SnapshotTesting
@testable import DesignSystem

final class ReposViewControllerTests: XCTestCase {
    var scheduler: TestScheduler!
    var reposTableView: ReposTableView!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        reposTableView = ReposTableView(scheduler: scheduler)
    }
    
    override func tearDown() {
        super.tearDown()
        scheduler = nil
    }
    
    func testReposViewController_when_itIs_inState_show() {
        let stateObservable: Observable<ReposViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .show(makeViewModel()))
            ]
        ).asObservable()
        
        let sut = ReposViewController(
            repoListView: reposTableView,
            state: stateObservable.asObservable(),
            scheduler: scheduler
        )
        
        _ = sut.view
        
        scheduler.advanceTo(10)
        
        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }

    func testReposViewController_when_itIs_inState_loading() throws {
        let stateObservable: Observable<ReposViewControllerState> = scheduler.createColdObservable(
            [
                .next(5, .loading)
            ]
        ).asObservable()

        let sut = ReposViewController(
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

    func testReposViewController_when_itIs_inState_error() throws {
        let stateObservable: Observable<ReposViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .error)
            ]
        ).asObservable()

        let sut = ReposViewController(
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
    
    func testReposViewController_when_itTriggers_tappedRepoAction() throws {
        let stateObservable: Observable<ReposViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .show(makeViewModel()))
            ]
        ).asObservable()
        
        let sut = ReposViewController(
            repoListView: reposTableView,
            state: stateObservable.asObservable(),
            scheduler: scheduler
        )
        
        _ = sut.view
        
        scheduler.advanceTo(10)
        
        var didTapIndex: IndexPath?
        
        sut.onAction = { action in
            if case .tappedRepo(atIndex: let index) = action {
                didTapIndex = index
            }
        }
        
        reposTableView.delegate?.tableView?(reposTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        scheduler.advanceTo(40)
        
        let tappedIndex = try XCTUnwrap(didTapIndex)
        XCTAssertEqual(tappedIndex, IndexPath(row: 0, section: 0))
    }
    
    func testReposViewController_when_itTriggers_fetchedAction_whenItLoads() {
        let stateObservable: Observable<ReposViewControllerState> = scheduler.createColdObservable(
            [
                .next(1, .show(makeViewModel()))
            ]
        ).asObservable()
        
        let sut = ReposViewController(
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

    func makeViewModel() -> ReposTableViewModel {
        let ids: [Int] = [0, 1, 2, 3, 4, 5, 6]
        var cells: [ReposTableViewCellViewModel] = []
        ids.forEach { id in
            let author = UserProfileCompactViewModel(
                username: "aaa-carrr",
                profileImage: LoadableImage(
                    single: Single<UIImage>.just(UIImage(systemName: "person.circle.fill") ?? UIImage()),
                    defaultImage: UIImage()
                )
            )
            let cell = ReposTableViewCellViewModel(
                id: id,
                repoName: "Repository",
                repoDescription: "Repository description",
                repoAuthor: author,
                repoStars: "34 starts",
                repoForks: "6 forks"
            )
            cells.append(cell)
        }
        let section = ReposTableViewSection(section: 0)
        let viewModel = ReposTableViewModel(
            section: section,
            cells: cells
        )
        return viewModel
    }
}
