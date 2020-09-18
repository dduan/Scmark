@testable import Scmark
import XCTest

final class ScmarkTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(markdownToHTML("Hello, *world*!"), "<p>Hello, <em>world</em>!</p>\n")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
