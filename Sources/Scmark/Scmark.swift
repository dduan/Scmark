import Ccmark

/// Convert 'text' (assumed to be a UTF-8 encoded string with length
/// 'len') from CommonMark Markdown to HTML, returning a null-terminated,
/// UTF-8-encoded string. It is the caller's responsibility
/// to free the returned buffer.
public func markdownToHTML(_ text: String, options: Options = []) -> String {
    String(cString: cmark_markdown_to_html(text, text.utf8.count, options.rawValue))
}

/// The library version as integer for runtime checks.
///
/// * Bits 16-23 contain the major version.
/// * Bits 8-15 contain the minor version.
/// * Bits 0-7 contain the patchlevel.
///
/// In hexadecimal format, the number 0x010203 represents version 1.2.3.
public func cmarkVersion() -> Int {
    Int(cmark_version())
}

/// The library version string for runtime checks.
public func cmarkVersionString() -> String {
    String(cString: cmark_version_string())
}
