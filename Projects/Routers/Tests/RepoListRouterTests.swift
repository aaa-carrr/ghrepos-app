import UIKit
import XCTest
import DesignSystem
import Reducers
@testable import Routers

final class RepoListRouterTests: XCTestCase {
    var sut: RepoListRouter!
    var navigationMock: UINavigationControllerMock!

    override func setUp() {
        super.setUp()
        navigationMock = UINavigationControllerMock()
        sut = RepoListRouter(navigationController: navigationMock)
    }

    override func tearDown() {
        super.tearDown()
        navigationMock = nil
        sut = nil
    }

    func testRepoListRouter_setUp() {
        sut.setUp()
        XCTAssertTrue(navigationMock.didPushViewController)
    }

    func testRepoListRouter_showController() {
        sut.show(UIViewController())
        XCTAssertTrue(navigationMock.didPushViewController)
    }

    func testRepoListRouter_showRepo() {
        let repo = RepoStateModel(
            id: 0,
            name: "",
            description: "",
            owner: RepoStateModel.OwnerStateModel(
                name: "",
                avatarUrl: ""
            ),
            stars: 0,
            forks: 0
        )
        
        sut.show(repo: repo)
        XCTAssertTrue(navigationMock.didPushViewController)
    }
}

final class UINavigationControllerMock: UINavigationController {
    private(set) var didPushViewController: Bool = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPushViewController = true
    }
}
