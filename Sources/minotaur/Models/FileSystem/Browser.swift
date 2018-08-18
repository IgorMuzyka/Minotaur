
import FileKit
import Foundation

public class Browser {

    public private(set) var path: Path
	public private(set) var table: Table!
	public private(set) var selection: UInt16!

    public init(url: URL) {
        self.path = Path(url: url)!
		resetSelection()
		updateTable()
    }

	public func previous() {
		if selection == 0 {
			selection = UInt16(contents.count - 1)
		} else {
			selection -= 1
		}
	}

	public func next() {
		if selection == contents.count - 1 {
			selection = 0
		} else {
			selection += 1
		}
	}

	public func exit() {
		path = path.parent
		resetSelection()
		updateTable()
	}

	public func navigate() {
		path = contents[Int(selection)].path
		resetSelection()
		updateTable()
	}

	public var render: (Display.Size) -> Void {
		return { [unowned self] size in
			Color.current.wrap {
				addstr(self.path.description)
				addstr("\n")
			}
			self.table.render(size, self.selection)
		}
	}

	private func resetSelection() {
		selection = 0
	}

	private func updateTable() {
		self.table = Table(cells: contents.map { View(text: $0.description) })
	}
}

extension Browser {

    private var files: [File] {
        return children.filter { $0.fileType! == .regular }.map(File.init)
    }

    private var directories: [Directory] {
        return children.filter { $0.fileType! == .directory }.map(Directory.init)
    }

    private var symbolicLinks: [SymbolicLink] {
        return children.filter { $0.fileType! == .symbolicLink }.map(SymbolicLink.init)
    }

    private var contents: [BrowserItem] {
        return (directories as [BrowserItem])
            + (files as [BrowserItem])
            + (symbolicLinks as [BrowserItem])
    }

    private var children: [Path] {
        return path.children().filter { $0.fileType != nil }
    }
}
