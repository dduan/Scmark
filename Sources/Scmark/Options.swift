public struct Options: OptionSet {
    public let rawValue: Int32

    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    // MARK: - Options affecting rendering

    /// Include a `data-sourcepos` attribute on all block elements.
    public static let sourcepos = 1 << 1

    /// Render `softbreak` elements as hard line breaks.
    public static let hardbreaks = 1 << 2

    /// Render raw HTML and unsafe links (`javascript:`, `vbscript:`,
    /// `file:`, and `data:`, except for `image/png`, `image/gif`,
    /// `image/jpeg`, or `image/webp` mime types).  By default,
    /// raw HTML is replaced by a placeholder HTML comment. Unsafe
    /// links are replaced by empty strings.
    public static let unsafe = 1 << 17

    /// Render `softbreak` elements as spaces.
    public static let noBreaks = 1 << 4

    // MARK: - Options affecting parsing

    /// Validate UTF-8 in the input before parsing, replacing illegal
    /// sequences with the replacement character U+FFFD.
    public static let validateUTF8 = 1 << 9

    /// Convert straight quotes to curly, --- to em dashes, -- to en dashes.
    public static let smart = 1 << 10
}
