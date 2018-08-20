
import Cncurses

public class Application {

//    enum Mode {
//
//        case navigation
//        case interactive
//        case fuzzySearch
//    }

    private let screen = Screen()
    private var keyboard: Keyboard!
    private let browser = Browser()
//    private var mode: Mode = .navigation

    public init() {
       setup()
    }

    public func run() {
        loop()
    }

	private func setup() {
		screen.setup()
        keyboard = .navigation(application: self, browser: browser)
	}

    private func loop() {
        repeat {
			screen.render(render)
            keyboard.handleInput()
        } while true
    }

    public func terminate() {
		screen.teardown()
        exit(EX_OK)
    }

    private var render: (Screen.Size) -> Void {
        return { [unowned self] size in
            self.browser.render(size, .zero)
        }
    }
}
