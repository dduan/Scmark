# Scmark

Thin, faithful, but Swift-y wrappers for [cmark][].

## Supported Environment


| Swift 5.3 |
|-|
|![macOS](https://github.com/dduan/Scmark/workflows/macOS/badge.svg)|
|![Amazon Linux 2](https://github.com/dduan/Scmark/workflows/Amazon%20Linux%202/badge.svg)|
|![Ubuntu Focal X](https://github.com/dduan/Scmark/workflows/Ubuntu%20Focal/badge.svg)|
|![Ubuntu Bionic](https://github.com/dduan/Scmark/workflows/Ubuntu%20Bionic/badge.svg)|
|![CentOS 8](https://github.com/dduan/Scmark/workflows/CentOS%208/badge.svg)|

## Installation

Swift Package Manager:

```swift
.package(url: "https://github.com/dduan/Scmark", .branch("main"))
```


## Overview

Scmark is a wrapper around the library part of [cmark][]. It provides:

- Simple CommonMark-to-HTML translation.
- Syntax-tree-based traversal and manipulation.
- Procedural input parsing.
- Tree-to CommonMark/XML/HTML/Groff(man page)/LaTeX translation.

Scmark strives to provide good ergonomics for Swift users, while staying as
close cmark's original interface as possible. Examples where APIs were adapted
for Swift:

- Names following Swift's [API Design Guidelines][].
- Tree `Node`, `Parser`, and `TreeIterator` has object-oriented interfaces.
- Enhance with type-safty: Whereas C uses an special enum case (e.g.
  `CMARK_EVENT_NONE`) to represent errors, Scmark replaces it with `Optional`.
  `Bool` in place of `int`s from C when it's appropirate, etc.

Scmark ships with a copy of cmark, and has no extra dependencies.

## Usage

## License

MIT. See `LICENSE.md`.

[cmark]: https://github.com/commonmark/cmark
[API Design Guidelines]: https://swift.org/documentation/api-design-guidelines
