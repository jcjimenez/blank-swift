import XCTest
@testable import Blank

final class BlankTests: XCTestCase {
    var systemUnderTest: Blank!

    override func setUp() async throws {
        systemUnderTest = Blank()
    }

    override func tearDown() async throws {
        systemUnderTest = nil
    }

    func testAdd() throws {
        let left = 1
        let right = 2
        let result = systemUnderTest.add(left, right)
        XCTAssertEqual(result, left + right)
    }

    func testText() throws {
        XCTAssertEqual(systemUnderTest.text, "Hello, World!")
    }
}
