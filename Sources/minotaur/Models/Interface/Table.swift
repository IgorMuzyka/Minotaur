
import Foundation
import Cncurses

public class Table {

	public var cells: [View]

	public init(cells: [View]) {
		self.cells = cells
	}

	public var render: (Display.Size, UInt16) -> Void {
		return { [unowned self] size, selection in
			let height = self.cells.map { $0.height }.reduce(0, +)

			if height <= size.height {
				self.cells.enumerated().forEach { index, view in
					let color: Color = (index == selection) ? .selection : .main

					color.wrap(view.render)
					addstr("\n")
				}
			} else {
				// implement
			}
		}
	}
}
