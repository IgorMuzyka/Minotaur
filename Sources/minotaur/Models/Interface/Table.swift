
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
			let sequence: [(Int, View)]
			let selected: Int

			if height <= size.height {
				selected = Int(selection)
				sequence = self.cells.enumerated().map { $0 }
			} else {
				let offset = Int(selection)
				let frame = Int(size.height - 1)
				let content = height

				let frames = content / frame
//				let frameOffset = offset % frame

//				let position = size.height - offset
//				let frames = height / frame
//				let frame = position / frame

//				if offset > height / 2 {

				sequence = self.cells.enumerated().shifted(by: frames * frame).chunks(frame).first!
				selected = offset % frame
//				} else {
//					sequence = self.cells.enumerated().shifted(by: 0).chunks(frame).first!
//					selected = frame - offset
//				}
			}

			sequence.forEach { index, view in
				let color: Color = index == selected ? .selection : .main

				color.wrap(view.render)
				addstr("\n")
			}
		}
	}
}
