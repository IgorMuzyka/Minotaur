
import Foundation
import SwiftShell

public func currentPath() -> URL {
    let path = SwiftShell.run("pwd").stdout
    let url = URL(string: "file://" + path)!
    return url
}
