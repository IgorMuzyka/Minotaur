
import Cncurses

public class View {

	let text: String

	public init(text: String) {
		self.text = text
	}

	var width: Int {
		return text.split(separator: "\n").sorted(by: { $0.count > $1.count }).first!.count
	}

	var height: Int {
		return text.split(separator: "\n").count
	}

	public var render: () -> Void {
		return { [unowned self] in
			addstr(self.text)
		}
	}
}
