
import Cncurses

public class Application {

    let display = Display()
    let keyboard = Keyboard()
    let browser = Browser(url: Scripts.currentPath())

    public init() {
       setup()
    }

    public func run() {
        loop()
    }

	private func setup() {
		display.setup()

		keyboard.register(key: Int32(UnicodeScalar("q").value)) { [unowned self] in
			self.terminate()
		}

		keyboard.register(key: Int32(UnicodeScalar("c").value)) { [unowned self] in
			Scripts.changeDirectory(to: self.browser.path.description)

			

//			clear()
//			addstr("lol")
//			addstr(self.browser.path.description)
//			addstr("lol")
//			refresh()
//			self.terminate()
		}

		keyboard.register(key: Keyboard.arrowUp) { [unowned self] in
			self.browser.previous()
		}

		keyboard.register(key: Keyboard.arrowDown) { [unowned self] in
			self.browser.next()
		}

		keyboard.register(key: Keyboard.arrowLeft) { [unowned self] in
			self.browser.exit()
		}

		keyboard.register(key: Keyboard.arrowRight) { [unowned self] in
			self.browser.navigate()
		}

		keyboard.register(key: Keyboard.return) { [unowned self] in
			// if file open it if directory change to it
			self.browser.navigate()
		}
	}

    private func loop() {
        repeat {
			display.render(browser.render)
            keyboard.handleInput()
        } while true
    }

    public func terminate() {
		display.teardown()
        exit(EX_OK)
    }
}
