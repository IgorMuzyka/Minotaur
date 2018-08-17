
import FileKit

extension Browser {

    public struct Directory: BrowserItem {

        public let path: Path

        public init(path: Path) {
            self.path = path
        }

        public var description: String {
            return path.fileName + "/"
        }
    }
}
