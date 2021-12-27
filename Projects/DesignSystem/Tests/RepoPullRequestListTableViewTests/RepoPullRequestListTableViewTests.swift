import XCTest
import RxSwift
import RxTest
import SnapshotTesting
@testable import DesignSystem

final class RepoPullRequestListTableViewTests: XCTestCase {
    var sut: RepoPullRequestListTableView!
    var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: .zero)
        sut = RepoPullRequestListTableView(scheduler: scheduler)
    }

    override func tearDown() {
        super.tearDown()
        scheduler = nil
        sut = nil
    }

    func testRepoPullRequestListTableView_when_itBinds_toA_viewModel() {
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
        let observable = Observable<RepoPullRequestListTableViewModel>.just(viewModel)

        sut.bind(observable)

        scheduler.advanceTo(1)

        let size = ViewImageConfig.iPhoneSe.size ?? .zero

        assertSnapshot(matching: sut, as: .image(size: size))
    }

    func testRepoPullRequestListTableView_when_itBinds_toA_viewModel_thenReceivesNewValues() {
        let ids: [Int] = [0, 1, 2, 3]
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

        let newIds: [Int] = [0]
        var newCells: [RepoPullRequestListTableViewCellViewModel] = []
        newIds.forEach { id in
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
            newCells.append(cell)
        }

        let newViewModel = RepoPullRequestListTableViewModel(
            section: section,
            cells: newCells
        )


        let observable: Observable<RepoPullRequestListTableViewModel> = scheduler.createHotObservable(
            [
                .next(1, viewModel),
                .next(5, newViewModel)
            ]
        ).asObservable()

        sut.bind(observable)

        scheduler.advanceTo(1)
        scheduler.advanceTo(10)

        let size = ViewImageConfig.iPhoneSe.size ?? .zero

        assertSnapshot(matching: sut, as: .image(size: size))
    }
}
