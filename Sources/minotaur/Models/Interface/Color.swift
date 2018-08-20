
import Cncurses

public struct Color {

	private static var count: Int16 = 0

	private let index: Int32

	public init(foreground: Int32, background: Int32) {
		Color.count += 1
		index = Int32(Color.count)
		init_pair(Int16(index), Int16(foreground), Int16(background))
	}

	public static var main: Color = Color(foreground: COLOR_RED, background: COLOR_BLACK)
	public static var selection: Color = Color(foreground: COLOR_GREEN, background: COLOR_BLACK)
	public static var current: Color = Color(foreground: COLOR_MAGENTA, background: COLOR_BLACK)

	public func wrap(_ renderFunction: @escaping () -> Void) -> () -> Void {
        return {
            attron(COLOR_PAIR(self.index))
            renderFunction()
            attroff(COLOR_PAIR(self.index))
        }
	}
}
