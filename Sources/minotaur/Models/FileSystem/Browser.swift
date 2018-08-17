
import FileKit
import Foundation

public class Browser: CustomStringConvertible {

    public let path: Path

    public init(url: URL) {
        self.path = Path(url: url)!
    }

    public var description: String {
        return contents.map { $0.description }.joined(separator: "\n")
    }
}

extension Browser {

    public var files: [File] {
        return children.filter { $0.fileType! == .regular }.map(File.init)
    }

    public var directories: [Directory] {
        return children.filter { $0.fileType! == .directory }.map(Directory.init)
    }

    public var symbolicLinks: [SymbolicLink] {
        return children.filter { $0.fileType! == .symbolicLink }.map(SymbolicLink.init)
    }

    public var contents: [BrowserItem] {
        return (directories as [BrowserItem])
            + (files as [BrowserItem])
            + (symbolicLinks as [BrowserItem])
    }

    private var children: [Path] {
        return path.children().filter { $0.fileType != nil }
    }
}
