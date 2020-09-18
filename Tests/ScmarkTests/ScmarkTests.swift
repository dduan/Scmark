import Scmark
import XCTest

final class ScmarkTests: XCTestCase {
    func testSimpleMarkdownToHTML() {
        XCTAssertEqual(markdownToHTML("Hello, *world*!"), "<p>Hello, <em>world</em>!</p>\n")
    }

    func testParser() {
        let parser = Parser()
        let node = parser.parse(document: "Hello, *world*!")
        XCTAssertEqual(node.renderHTML(), "<p>Hello, <em>world</em>!</p>\n")
    }

    func testIterator() {
        let root = Parser().parse(document: "Hello, *world*!")
        let nodeTypes = Tree(root: root)
            .filter { $0.0 == .enter }
            .map { $0.1.typeString() }

        XCTAssertEqual(nodeTypes, ["document", "paragraph", "text", "emph", "text", "text"])
    }
}
