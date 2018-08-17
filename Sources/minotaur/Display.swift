
import Cncurses

public struct Display {

    public struct Size {

        let x: Int32
        let y: Int32
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

    public func print(string: String) { // need to remake this to describe with a structure
        clear()
        start_color()
        init_pair(1, Int16(COLOR_RED), Int16(COLOR_BLACK))
        attron(COLOR_PAIR(1))
        addstr(string)
        attroff(COLOR_PAIR(1))

        init_pair(2, Int16(COLOR_BLACK), Int16(COLOR_GREEN))
        attron(COLOR_PAIR(2))
        addstr(string)
        attroff(COLOR_PAIR(2))

        refresh()
    }

    public var size: Size {
        return Size(x: getmaxx(stdscr), y: getmaxy(stdscr))
    }
}
