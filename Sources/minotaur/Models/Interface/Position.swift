
import Cncurses

extension Screen {

    public struct Position {

        public var x: Int
        public var y: Int

        public func wrap(_ renderFunction: @escaping () -> Void) -> () -> Void {
            return {
                move(Int32(self.y), Int32(self.x))
                renderFunction()
            }
        }

        public static var zero: Position {
            return Position(x: 0, y: 0)
        }
    }
}
