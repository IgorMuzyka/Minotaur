
import Cncurses

public struct View {

	let text: String

	public init(text: String) {
		self.text = text
	}

	public var render: () -> Void {
        return {
            addstr(self.text)
        }
	}
}
