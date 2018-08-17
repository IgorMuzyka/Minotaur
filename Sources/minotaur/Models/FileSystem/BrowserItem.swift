
import FileKit

public protocol BrowserItem: CustomStringConvertible {

    var path: Path { get }
}

extension BrowserItem {

    public var size: Browser.Size {
        return Browser.Size(value: path.fileSize)
    }
}
