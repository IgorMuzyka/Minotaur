import XCTest

import minotaurTests

var tests = [XCTestCaseEntry]()
tests += minotaurTests.allTests()
XCTMain(tests)