import Ccmark

enum NodeType: RawRepresentable {
    // Block
    case document
    case blockQuote
    case list
    case item
    case codeBlock
    case htmlBlock
    case customBlock
    case paragraph
    case heading
    case thematicBreak


    // Inline
    case text
    case softBreak
    case lineBreak
    case code
    case htmlInline
    case customInline
    case emphasize
    case strong
    case link
    case image

    static let firstBlock = NodeType.document
    static let lastBlock = NodeType.thematicBreak
    static let firstInline = NodeType.text
    static let lastInline = NodeType.image

    init?(rawValue: cmark_node_type) {
        switch rawValue {
        case CMARK_NODE_DOCUMENT:
            self = .document
        case CMARK_NODE_BLOCK_QUOTE:
            self = .blockQuote
        case CMARK_NODE_LIST:
            self = .list
        case CMARK_NODE_ITEM:
            self = .item
        case CMARK_NODE_CODE_BLOCK:
            self = .codeBlock
        case CMARK_NODE_HTML_BLOCK:
            self = .htmlBlock
        case CMARK_NODE_CUSTOM_BLOCK:
            self = .customBlock
        case CMARK_NODE_PARAGRAPH:
            self = .paragraph
        case CMARK_NODE_HEADING:
            self = .heading
        case CMARK_NODE_THEMATIC_BREAK:
            self = .thematicBreak
        case CMARK_NODE_FIRST_BLOCK:
            self = .firstBlock
        case CMARK_NODE_LAST_BLOCK:
            self = .lastBlock
        case CMARK_NODE_TEXT:
            self = .text
        case CMARK_NODE_SOFTBREAK:
            self = .softBreak
        case CMARK_NODE_LINEBREAK:
            self = .lineBreak
        case CMARK_NODE_CODE:
            self = .code
        case CMARK_NODE_HTML_INLINE:
            self = .htmlInline
        case CMARK_NODE_CUSTOM_INLINE:
            self = .customInline
        case CMARK_NODE_EMPH:
            self = .emphasize
        case CMARK_NODE_STRONG:
            self = .strong
        case CMARK_NODE_LINK:
            self = .link
        case CMARK_NODE_IMAGE:
            self = .image
        case CMARK_NODE_FIRST_INLINE:
            self = .firstInline
        case CMARK_NODE_LAST_INLINE:
            self = .lastInline
        default:
            return nil
        }
    }

    var rawValue: cmark_node_type {
        switch self {
        case .document:
            return CMARK_NODE_DOCUMENT
        case .blockQuote:
            return CMARK_NODE_BLOCK_QUOTE
        case .list:
            return CMARK_NODE_LIST
        case .item:
            return CMARK_NODE_ITEM
        case .codeBlock:
            return CMARK_NODE_CODE_BLOCK
        case .htmlBlock:
            return CMARK_NODE_HTML_BLOCK
        case .customBlock:
            return CMARK_NODE_CUSTOM_BLOCK
        case .paragraph:
            return CMARK_NODE_PARAGRAPH
        case .heading:
            return CMARK_NODE_HEADING
        case .thematicBreak:
            return CMARK_NODE_THEMATIC_BREAK
        case .firstBlock:
            return CMARK_NODE_FIRST_BLOCK
        case .lastBlock:
            return CMARK_NODE_LAST_BLOCK
        case .text:
            return CMARK_NODE_TEXT
        case .softBreak:
            return CMARK_NODE_SOFTBREAK
        case .lineBreak:
            return CMARK_NODE_LINEBREAK
        case .code:
            return CMARK_NODE_CODE
        case .htmlInline:
            return CMARK_NODE_HTML_INLINE
        case .customInline:
            return CMARK_NODE_CUSTOM_INLINE
        case .emphasize:
            return CMARK_NODE_EMPH
        case .strong:
            return CMARK_NODE_STRONG
        case .link:
            return CMARK_NODE_LINK
        case .image:
            return CMARK_NODE_IMAGE
        case .firstInline:
            return CMARK_NODE_FIRST_INLINE
        case .lastInline:
            return CMARK_NODE_LAST_INLINE
        }
    }
}
