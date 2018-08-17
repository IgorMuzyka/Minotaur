
import FileKit

extension Browser {

    public struct File: BrowserItem {

        public let path: Path

        public init(path: Path) {
            self.path = path
        }

        public var description: String {
            return path.fileName
        }
    }
}
