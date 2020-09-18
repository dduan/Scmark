import Ccmark

public final class Parser {
    let parser: OpaquePointer

    /// Creates a new parser object.
    public init(options: Options = []) {
        parser = cmark_parser_new(options.rawValue)
    }

    /// Frees memory allocated for a parser object.
    deinit {
        cmark_parser_free(parser)
    }

    /// Feeds a string.
    public func feed(_ text: String) {
        cmark_parser_feed(parser, text, text.utf8.count)
    }

    /// Finish parsing and return a root of a tree of nodes.
    public func finish() -> Node {
        Node(node: cmark_parser_finish(parser), ownsNodeMemory: true)
    }

    /// Parse a CommonMark document.
    ///
    /// - Returns: root to a tree of nodes.
    public func parse(document: String, options: Options = []) -> Node {
        Node(node: cmark_parse_document(document, document.utf8.count, options.rawValue), ownsNodeMemory: true)
    }
}
