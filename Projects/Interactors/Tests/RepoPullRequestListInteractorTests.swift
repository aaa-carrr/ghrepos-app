import XCTest
import RxSwift
import RxTest
import Networking
@testable import Interactors

final class RepoPullRequestListInteractorTests: XCTestCase {
    var sut: RepoPullRequestListInteractor!
    var networkingMock: NetworkingTypeMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        networkingMock = NetworkingTypeMock()
        sut = RepoPullRequestListInteractor(networking: networkingMock)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        networkingMock = nil
        scheduler = nil
        disposeBag = nil
    }

    func testRepoPullRequestListInteractor_whenItIsAsked_toRetrieve_pullRequests() {
        let resource = RepoPullRequestListResource(author: "author", repo: "repo")
        let single = sut.pullRequestList(from: resource)

        var didReceiveExpectedError: Bool = false

        single
            .subscribe(on: scheduler)
            .subscribe(onFailure: { _ in
                didReceiveExpectedError = true
            }).disposed(by: disposeBag)

        scheduler.advanceTo(100)

        XCTAssertTrue(didReceiveExpectedError)
    }

    func testRepoPullRequestListInteractor_whenItIsAsked_toRetrieve_authorImage() {
        var receivedImage: UIImage?

        let imageToBeReturned = UIImage()

        networkingMock.imageToReturn = imageToBeReturned

        let single = sut.authorProfileImage(from: "https://github.com/aaa-carrr")

        single
            .subscribe(on: scheduler)
            .subscribe(onSuccess: { image in
                receivedImage = image
            }).disposed(by: disposeBag)

        scheduler.advanceTo(100)

        XCTAssertNotNil(receivedImage)
        XCTAssertTrue(receivedImage === imageToBeReturned)
    }
}
