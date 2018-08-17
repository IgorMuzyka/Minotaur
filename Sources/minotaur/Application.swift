
import Cncurses

public class Application {

    let display = Display()
    let keyboard = Keyboard()
    let browser = Browser(url: currentPath())

    public init() {
        display.setup()

        keyboard.register(key: Int32(UnicodeScalar("q").value)) { [unowned self] in
            self.display.teardown()
            self.terminate()
        }
    }

    public func run() {
        loop()
    }

    private func loop() {
        repeat {
            display.print(string: browser.description)
            keyboard.handleInput()
        } while true
    }

    public func terminate() {
        exit(EX_OK)
    }
}
