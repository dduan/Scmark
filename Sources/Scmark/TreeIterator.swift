import Ccmark

/// Low-level mechanism to visit the tree-representation of a document.
/// It's implemented directly with cmark's API.
///
/// An iterator will walk through a tree of nodes, starting from a root
/// node, returning one node at a time, together with information about
/// whether the node is being entered or exited.  The iterator will
/// first descend to a child node, if there is one.  When there is no
/// child, the iterator will go to the next sibling.  When there is no
/// next sibling, the iterator will return to the parent (but with
/// a `Event.exit`). The iterator will return `Event.done` when it reaches the
/// root node again. One natural application is an HTML renderer, where an
///`ENTER` event outputs an open tag and an `.exit` event outputs a close tag.
/// An iterator might also be used to transform an AST in some systematic way,
//for example, turning all level-3 headings into regular paragraphs.
///
///     func example(root: Node) {
///         var event: TreeIterator.Event?
///         let iter = TreeIterator(root)
///         repeat {
///             event = iter.next()
///             let node = iter.node()
///
///             // do things with `event` and `node`
///         } while event != nil
///     }
///
/// Iterators will never return `.exit` events for leaf nodes, which are nodes
/// of type:
///
/// * NodeType.block
/// * NodeType.break
/// * NodeType.codeBlock
/// * NodeType.text
/// * NodeType.softbreak
/// * NodeType.linebreak
/// * NodeType.code
/// * NodeType.htmlInline
///
/// Nodes must only be modified after an `.exit` event, or an `.enter` event for
/// leaf nodes.
public class TreeIterator: IteratorProtocol {
    var iter: OpaquePointer

    /// Creates a new iterator starting at 'root'. The current node and event
    /// type are undefined until 'next()' is called for the first time.
    public init(root: Node) {
        iter = cmark_iter_new(root.node)
    }

    /// Frees the memory allocated for an iterator.
    deinit {
        cmark_iter_free(iter)
    }

    /// Advances to the next node and returns the event type (`Event.enter`
    public func next() -> Event? {
        let event = cmark_iter_next(iter)
        return event == CMARK_EVENT_NONE ? nil : Event(rawValue: event)
    }

    /// - Returns: the current node.
    public func node() -> Node? {
        if let node = cmark_iter_get_node(iter) {
            return Node(node: node, ownsNodeMemory: false)
        }

        return nil
    }

    /// - Returns: the current event type.
    public func event() -> Event? {
        let event = cmark_iter_get_event_type(iter)
        return event == CMARK_EVENT_NONE ? nil : Event(rawValue: event)
    }

    /// - Returns: the root node.
    public func root() -> Node? {
        if let node = cmark_iter_get_root(iter) {
            return Node(node: node, ownsNodeMemory: false)
        }

        return nil
    }

    /// Resets the iterator so that the current node is 'current' and
    /// the event type is 'Event'. The new current node must be a
    /// descendant of the root node or the root node itself.
    public func reset(node: Node, event: Event) {
        cmark_iter_reset(iter, node.node, event.rawValue)
    }

    public enum Event: Equatable {
        case done
        case enter
        case exit

        init?(rawValue: cmark_event_type) {
            switch rawValue {
            case CMARK_EVENT_DONE:
                self = .done
            case CMARK_EVENT_ENTER:
                self = .enter
            case CMARK_EVENT_EXIT:
                self = .exit
            default:
                return nil
            }
        }

        var rawValue: cmark_event_type {
            switch self {
            case .done:
                return CMARK_EVENT_DONE
            case .enter:
                return CMARK_EVENT_ENTER
            case .exit:
                return CMARK_EVENT_EXIT
            }
        }
    }
}
