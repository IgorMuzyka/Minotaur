
import Foundation
import SwiftShell

public enum Scripts {

	public static func currentPath() -> URL {
		let path = main.currentdirectory
		let url = URL(string: "file://" + path)!
		return url
	}

	public static func open(path: String) {
		run("open \(path)")
	}

    public static func preview(path: String) -> String {
        return run("cat \(path)").stdout
    }

	public static func changeDirectory(to path: String) {
		main.currentdirectory = path
	}
}
