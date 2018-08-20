
import Cncurses

public class Keyboard {

    public typealias Handler = () -> Void
    public typealias Key = Int32

    private var handlers = [Key: Handler]()

    public func register(key: Key, handler: @escaping Handler) {
        handlers[key] = handler
    }

    public func handleInput() {
        process(key: read())
    }

    public func read() -> Key {
        return getch()
    }

    public func process(key: Key) {
        handlers[key]?()
    }
}

extension Keyboard.Key {

    public static var arrowUp: Keyboard.Key { return 259 }
    public static var arrowDown: Keyboard.Key { return 258 }
    public static var arrowLeft: Keyboard.Key { return 260 }
    public static var arrowRight: Keyboard.Key { return 261 }
    public static var `return`: Keyboard.Key { return 13 }
    public static var q: Keyboard.Key { return Int32(UnicodeScalar("q").value) }
}
