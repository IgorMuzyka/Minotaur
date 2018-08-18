
import Cncurses

public struct Display {

    public struct Size {

        let width: Int32
        let height: Int32
    }

    public func setup() {
        initscr()                   // Init window. Must be first
        cbreak()
        noecho()                    // Don't echo user input
        nonl()                      // Disable newline mode
        intrflush(stdscr, true)     // Prevent flush
        keypad(stdscr, true)        // Enable function and arrow keys
        curs_set(1)                 // Set cursor to invisible
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

    public var size: Size {
        return Size(width: getmaxx(stdscr), height: getmaxy(stdscr))
    }
}
