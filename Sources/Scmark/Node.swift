import Ccmark

public class Node {
    let node: OpaquePointer
    let ownsNodeMemory: Bool

    /// Creates a new node of type 'type'.  Note that the node may have
    /// other required properties, which it is the caller's responsibility
    /// to assign.
    public init(_ type: NodeType) {
        node = cmark_node_new(type.rawValue)
        ownsNodeMemory = true
    }

    init(node: OpaquePointer, ownsNodeMemory: Bool) {
        self.node = node
        self.ownsNodeMemory = ownsNodeMemory
    }

    /// Frees the memory allocated for a node and any children.
    deinit {
        if ownsNodeMemory {
            cmark_node_free(node)
        }
    }

    // MARK: - Tree Traversal

    /// - Returns: the next node in the sequence after 'node', or `nil` if
    /// there is none.
    public func next() -> Node? { extractNode(cmark_node_next) }

    /// - Returns: the previous node in the sequence after 'node', or `nil` if
    /// there is none.
    public func previous() -> Node? { extractNode(cmark_node_previous) }

    /// - Returns: the parent of 'node', or `nil` if there is none.
    public func parent() -> Node? { extractNode(cmark_node_parent) }

    /// - Returns: the first child of 'node', or `nil` if 'node' has no children.
    public func firstChild() -> Node? { extractNode(cmark_node_first_child) }

    /// - Returns: the last child of 'node', or `nil` if 'node' has no children.
    public func lastChild() -> Node? { extractNode(cmark_node_last_child) }

    /// - Returns: the type of 'node', or `nil` on error.
    public func type() -> NodeType? {
        NodeType(rawValue: cmark_node_get_type(node))
    }

    /// - Returns: Like 'type()', but a string representation
    /// of the type, or `"<unknown>"`.
    public func typeString() -> String {
        String(cString: cmark_node_get_type_string(node))
    }

    /// - Returns: the string contents of 'node', or an empty
    /// string if none is set.  Returns `nil` if called on a
    /// node that does not have string content.
    public func literal() -> String? {
        if let string = cmark_node_get_literal(node) {
            return String(cString: string)
        }

        return nil
    }

    /// - Returns: the heading level of 'node', or `nil` if 'node' is not a heading.
    public func headingLevel() -> Int? {
        let level = Int(cmark_node_get_heading_level(node))
        return level == 0 ? nil : level
    }

    /// - Returns: the list type of 'node', or `nil` if 'node'
    /// is not a list.
    public func listType() -> ListType? {
        ListType(rawValue: (cmark_node_get_list_type(node)))
    }

    /// - Returns: the list delimiter type of 'node', or `nil` if 'node'
    /// is not a list.
    public func listDeliminator() -> ListDeliminator?  {
        ListDeliminator(rawValue: (cmark_node_get_list_delim(node)))
    }

    /// - Returns: starting number of 'node', if it is an ordered list, otherwise `nil`.
    public func listStart() -> Int? {
        let start = Int(cmark_node_get_list_start(node))
        return start == 0 ? nil : start
    }

    /// - Returns: `True` if 'node' is a tight list, `False` otherwise.
    public func isTightList() -> Bool {
        Int(cmark_node_get_list_tight(node)) == 1
    }

    /// - Returns: the info string from a fenced code block.
    public func fenceInfo() -> String {
        String(cString: cmark_node_get_fence_info(node))
    }

    /// - Returns: the URL of a link or image 'node', or an empty string
    /// if no URL is set.  Returns NULL if called on a node that is
    /// not a link or image.
    public func url() -> String {
        String(cString: cmark_node_get_url(node))
    }

    /// - Returns: the title of a link or image 'node', or an empty
    /// string if no title is set.  Returns NULL if called on a node
    /// that is not a link or image.
    public func title() -> String {
        String(cString: cmark_node_get_title(node))
    }

    /// Returns the literal "on enter" text for a custom 'node', or
    /// an empty string if no on_enter is set.  Returns `nil` if called
    /// on a non-custom node.
    public func onEnter() -> String? {
        if let literal = cmark_node_get_on_enter(node) {
            return String(cString: literal)
        }

        return nil
    }

    /// Returns the literal "on exit" text for a custom 'node', or
    /// an empty string if no on_exit is set.  Returns `nil` if
    /// called on a non-custom node.
    public func onExit() -> String? {
        if let literal = cmark_node_get_on_exit(node) {
            return String(cString: literal)
        }

        return nil
    }

    /// - Returns: the line on which 'node' begins.
    public func startLine() -> Int {
        Int(cmark_node_get_start_line(node))
    }

    /// - Returns: the column at which 'node' begins.
    public func startColumn() -> Int {
        Int(cmark_node_get_start_column(node))
    }

    /// - Returns: the line on which 'node' ends.
    public func endLine() -> Int {
        Int(cmark_node_get_end_line(node))
    }

    /// - Returns: the column at which 'node' ends.
    public func endColumn() -> Int {
        Int(cmark_node_get_end_column(node))
    }

    /// Sets the string contents of 'node'.
    ///
    /// - Returns: true if successful.
    public func set(literal: String) -> Bool {
        cmark_node_set_literal(node, literal) == 1
    }

    /// Sets the heading level of 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func set(headingLevel: Int) -> Bool {
        cmark_node_set_heading_level(node, Int32(headingLevel)) == 1
    }

    /// Sets starting number of 'node', if it is an ordered list.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func set(listStart: Int) -> Bool {
        cmark_node_set_list_start(node, Int32(listStart)) == 1
    }

    /// Sets the "tightness" of a list.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func set(isListTight: Bool) -> Bool {
        cmark_node_set_list_tight(node, Int32(isListTight ? 1 : 0)) == 1
    }

    /// Sets the info string in a fenced code block.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func set(fenseInfo: String) -> Bool {
        cmark_node_set_fence_info(node, fenseInfo) == 1
    }

    /// Sets the URL of a link or image 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func set(url: String) -> Bool {
        cmark_node_set_url(node, url) == 1
    }

    /// Sets the title of a link or image 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func set(title: String) -> Bool {
        cmark_node_set_title(node, title) == 1
    }

    /// Sets the literal text to render "on enter" for a custom 'node'.
    /// Any children of the node will be rendered after this text.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func setOnEnter(text: String) -> Bool {
        cmark_node_set_on_enter(node, text) == 1
    }

    /// Sets the literal text to render "on exit" for a custom 'node'.
    /// Any children of the node will be rendered before this text.
    ///
    /// - Returns: `True` on success and `False` on error.
    func setOnExit(text: String) -> Bool {
        cmark_node_set_on_exit(node, text) == 1
    }

    /// Unlinks a 'node', removing it from the tree.
    public func unlink() {
        cmark_node_unlink(node)
    }

    /// Inserts 'sibling' before 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func insertSibling(beforeSelf sibling: Node) -> Bool {
        cmark_node_insert_before(node, sibling.node) == 1
    }

    /// Inserts 'sibling' after 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func insertSibling(afterSelf sibling: Node) -> Bool {
        cmark_node_insert_after(node, sibling.node) == 1
    }

    /// Replaces 'node' with 'newNode' and unlinks 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func replace(with newNode: Node) -> Bool {
        cmark_node_replace(node, newNode.node) == 1
    }

    /// Adds 'child' to the beginning of the children of 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func prepend(child: Node) -> Bool {
        cmark_node_prepend_child(node, child.node) == 1
    }

    /// Adds 'child' to the end of the children of 'node'.
    ///
    /// - Returns: `True` on success and `False` on error.
    public func append(child: Node) -> Bool {
        cmark_node_append_child(node, child.node) == 1
    }

    /// Consolidates adjacent text nodes.
    public func consolidateTextNodes() {
        cmark_consolidate_text_nodes(node)
    }

    /// - Returns: a 'node' tree rendered as XML.
    public func renderXML(options: Options) -> String {
        String(cString: cmark_render_xml(node, options.rawValue))
    }

    /// - Returns: A 'node' tree rendered as an HTML fragment. It is up to the user
    /// to add an appropriate header and footer.
    public func renderHTML(options: Options = []) -> String {
        String(cString: cmark_render_html(node, options.rawValue))
    }

    /// - Returns: A 'node' tree rendered as a groff man page, without the header.
    public func renderManual(options: Options = [], width: Int) -> String {
        String(cString: cmark_render_man(node, options.rawValue, Int32(width)))
    }

    /// - Returns: A 'node' tree rendered as a CommonMark document.
    public func renderCommonMark(options: Options = [], width: Int) -> String {
        String(cString: cmark_render_commonmark(node, options.rawValue, Int32(width)))
    }

    /// - Returns: A 'node' tree rendered as a LaTeX document.
    public func renderLatex(options: Options = [], width: Int) -> String {
        String(cString: cmark_render_latex(node, options.rawValue, Int32(width)))
    }

    private func extractNode(_ extract: (OpaquePointer?) -> OpaquePointer?) -> Node? {
        if let node = extract(node) {
            return Node(node: node, ownsNodeMemory: true)
        }

        return nil
    }

    public enum ListType: Equatable {
        case bullet
        case ordered

        init?(rawValue: cmark_list_type) {
            switch rawValue {
            case CMARK_BULLET_LIST:
                self = .bullet
            case CMARK_ORDERED_LIST:
                self = .ordered
            default:
                return nil
            }
        }

        var rawValue: cmark_list_type {
            switch self {
            case .bullet:
                return CMARK_BULLET_LIST
            case .ordered:
                return CMARK_ORDERED_LIST
            }
        }
    }

    public enum ListDeliminator: Equatable {
        case period
        case parenthesis

        init?(rawValue: cmark_delim_type) {
            switch rawValue {
            case CMARK_PERIOD_DELIM:
                self = .period
            case CMARK_PAREN_DELIM:
                self = .parenthesis
            default:
                return nil
            }
        }

        var rawValue: cmark_delim_type {
            switch self {
            case .period:
                return CMARK_PERIOD_DELIM
            case .parenthesis:
                return CMARK_PAREN_DELIM
            }
        }
    }
}
