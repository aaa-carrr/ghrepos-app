import XCTest
import RxSwift
import RxTest
@testable import Networking

final class NetworkingTests: XCTestCase {
    var sut: Networking!

    override func setUp() {
        super.setUp()
        sut = Networking()
    }

    override func tearDown() {
        super.tearDown()
    }
}
