
import Cncurses

public struct Screen {

    public func setup() {
        initscr()
        cbreak()
        noecho()
        nonl()
        intrflush(stdscr, true)
        keypad(stdscr, true)
        curs_set(0)
    }

    public func teardown() {
        endwin()
    }

	public func render(_ renderFunction: (Size) -> Void) { // need to remake this to describe with a structure
        clear()
        start_color()
		renderFunction(size)
        refresh()
    }
}

extension Screen {

    public struct Size {

        var width: Int
        var height: Int
    }

    public var size: Size {
        return Size(width: Int(getmaxx(stdscr)), height: Int(getmaxy(stdscr)))
    }
}
