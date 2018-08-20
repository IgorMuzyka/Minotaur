
import Cncurses

public struct Table {

	public var cells: [View]

    public init(cells: [View]) {
		self.cells = cells
	}

	public var render: (Screen.Size, Screen.Position, Int) -> Void {
		return { size, position, selection in
            let frame = size.height
            let frameOffset = Int(floor(Double(selection / frame)))
            let selectionOffset = selection % frame
            let sequence = self.cells.chunks(frame).shifted(by: frameOffset).first!.enumerated()
            var offset = position

			sequence.forEach { index, view in
                let color: Color = index == selectionOffset ? .selection : .main
                (color.wrap | offset.wrap)(view.render)()
                offset.y += 1
			}
		}
	}
}
