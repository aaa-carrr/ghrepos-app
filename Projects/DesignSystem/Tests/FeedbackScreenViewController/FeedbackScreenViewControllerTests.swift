import XCTest
import SnapshotTesting
@testable import DesignSystem

final class FeedbackScreenViewControllerTests: XCTestCase {
    var sut: FeedbackScreenViewController!

    override func setUp() {
        super.setUp()
        sut = FeedbackScreenViewController()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testFeedbackScreenViewController_whenItIs_loading() {
        sut.setUp(with: .loading)
        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }

    func testFeedbackScreenViewController_whenItIs_inErrorState() {
        sut.setUp(with: .error)
        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }
}
