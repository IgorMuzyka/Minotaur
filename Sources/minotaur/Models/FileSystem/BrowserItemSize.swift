
import FileKit

extension Browser {

    public struct Size {

        public let value: UInt64
        public let unit: Unit

        public init(value: UInt64, unit: Unit) {
            self.value = value
            self.unit = unit
        }

        public init(value: UInt64?) {
            if let value = value {
                self = Size.reduceAndDefineUnit(value: value)
            } else {
                self.value = 0
                self.unit = .unavailable
            }
        }
    }
}

extension Browser.Size {

    private static func reduceAndDefineUnit(value: UInt64, currentUnit: Unit = .unavailable) -> Browser.Size {
        var unit: Unit
        var reducedValue: UInt64
        let level: UInt64 = 1024

        if value >= 1 && value <= level {
            return Browser.Size(value: value, unit: .byte)
        } else {
            reducedValue = value / level
            unit = currentUnit.next
        }

        if reducedValue < 1 || reducedValue > 1000 {
            return reduceAndDefineUnit(value: reducedValue, currentUnit: unit)
        } else {
            return Browser.Size(value: reducedValue, unit: unit)
        }
    }
}

extension Browser.Size: CustomStringConvertible {

    public var description: String {
        return "\t\(value) \(unit.postfix.rawValue)"
    }
}

extension Browser.Size {

    public enum Unit: IntegerLiteralType, RawRepresentable {

        case unavailable = -1
        case byte = 0
        case kilobyte = 1
        case megabyte = 2
        case gigabyte = 3
        case terabyte = 4
        case petabyte = 5
        case exabyte = 6

        fileprivate var next: Unit {
            return Unit(rawValue: rawValue + 1)!
        }

        public var postfix: Postfix {
            switch self {
            case .unavailable, .byte: return .none
            case .kilobyte: return .kilo
            case .megabyte: return .mega
            case .gigabyte: return .giga
            case .terabyte: return .tera
            case .petabyte: return .peta
            case .exabyte: return .exa
            }
        }
    }

    public enum Postfix: StringLiteralType {

        case none = "B"
        case kilo = "KB"
        case mega = "MB"
        case giga = "GB"
        case tera = "TB"
        case peta = "PB"
        case exa = "EB"
    }
}
