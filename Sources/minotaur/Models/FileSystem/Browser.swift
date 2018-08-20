
import FileKit
import Foundation

public class Browser {

    public private(set) var path: Path
	private var table: Table!
	private var selection: Int!
    public var selected: Path? {
        guard !path.isRegular else {
            return nil
        }
        return contents[selection].path
    }

    public init(url: URL = Scripts.currentPath()) {
        self.path = Path(url: url)!
		resetSelection()
		updateTable()
    }

    public func previous() {
        if selection == 0 {
            selection = table.cells.count - 1
        } else {
            selection -= 1
        }
    }

    public func next() {
        if selection == table.cells.count - 1 {
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
		select()
		resetSelection()
		updateTable()
	}

    public func preview() {
        select()
        resetSelection()

        let text = (try? TextFile(path: path).read())?.split(separator: "\n")
        let lines = text?.map { View(text: String($0)) } ?? [View(text: "failed to generate preview for \(path)")]
//        let lines = [View(text: (try? TextFile(path: path).read()) ?? "")]

        self.table = Table(cells: lines)
    }

	public var render: (Screen.Size, Screen.Position) -> Void {
		return { [unowned self] size, position in
            var offset = position
            var bounds = size
            let view = View(text: self.path.description)
            offset.wrap(Color.current.wrap(view.render))()

            offset.y += 1
            bounds.height -= 1

			self.table.render(bounds, offset, self.selection)
		}
	}

    private func select() {
        path = contents[selection].path
    }

	private func resetSelection() {
		selection = 0
	}

	private func updateTable() {
        guard !contents.isEmpty else {
            self.table = Table(cells: [View(text: String())])
            
            return
        }
        self.table = Table(cells: contents.map { View(text: $0.description) })
	}
}

extension Browser {

    private var files: [File] {
        return children.filter { $0.isRegular }.map(File.init)
    }

    private var directories: [Directory] {
        return children.filter { $0.isDirectory }.map(Directory.init)
    }

    private var symbolicLinks: [SymbolicLink] {
        return children.filter { $0.isSymbolicLink }.map(SymbolicLink.init)
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
