import XCTest
import RxSwift
import RxTest
import SnapshotTesting
@testable import DesignSystem

final class ReposTableViewTests: XCTestCase {
    var sut: ReposTableView!
    var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: .zero)
        sut = ReposTableView(scheduler: scheduler)
    }
    
    override func tearDown() {
        super.tearDown()
        scheduler = nil
        sut = nil
    }
    
    func testReposTableView_when_itBinds_toA_viewModel() {
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
        let observable = Observable<ReposTableViewModel>.just(viewModel)
        
        sut.bind(observable)
        
        scheduler.advanceTo(1)
        
        let size = ViewImageConfig.iPhoneSe.size ?? .zero
        
        assertSnapshot(matching: sut, as: .image(size: size))
    }
    
    func testReposTableView_when_itBinds_toA_viewModel_thenReceivesNewValues() {
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
        
        let newIds: [Int] = [0, 1, 3, 5]
        var newCells: [ReposTableViewCellViewModel] = []
        newIds.forEach { id in
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
            newCells.append(cell)
        }
        
        let newViewModel = ReposTableViewModel(
            section: section,
            cells: newCells
        )
        
        
        let observable: Observable<ReposTableViewModel> = scheduler.createHotObservable(
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
