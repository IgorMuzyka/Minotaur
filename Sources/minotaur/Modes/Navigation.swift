
extension Keyboard {

    public static func navigation(application: Application, browser: Browser) -> Keyboard {
        let keyboard = Keyboard()

        keyboard.register(key: .q, handler: application.terminate)
        keyboard.register(key: .arrowUp, handler: browser.previous)
        keyboard.register(key: .arrowDown, handler: browser.next)
        keyboard.register(key: .arrowLeft, handler: browser.exit)
        keyboard.register(key: .arrowRight, handler: browser.navigateOrPreview)

        //
        //        keyboard.register(key: Keyboard.return) { [unowned self] in
        //            if self.browser.isCurrentPathFile {
        //                Scripts.open(path: self.browser.path.fileName)
        //            } else {
        //                if let path = self.browser.selectionPath {
        //                    Scripts.open(path: path.fileName)
        //                } else {
        //                    // hmm what do we do then?
        //                }
        //            }
        //        }

        return keyboard
    }
}

extension Browser {

    public func navigateOrPreview() {
        guard !path.isRegular else { return }

        if selected?.isRegular ?? false {
            preview()
        } else {
            navigate()
        }
    }
}
