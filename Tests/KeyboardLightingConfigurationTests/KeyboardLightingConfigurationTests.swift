import XCTest
@testable import KeyboardLightingConfiguration

final class KeyboardLightingConfigurationTests: XCTestCase {
    func testEmptyInputThrowsError() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let inputParser: InputParser = DefaultInputParser()
        XCTAssertThrowsError(try inputParser.parse(input: ""))
    }
    
    func testEmptyInputThrowsEmptyInputError() {
        let inputParser: InputParser = DefaultInputParser()
        do {
            try inputParser.parse(input: "")
            XCTFail()
        } catch let error as InputParsingError {
            XCTAssertEqual(error.kind, InputParsingError.ErrorKind.EmptyInput)
        } catch {
            XCTFail()
        }
    }
    
    func testThrowsNoValidEntryFoundError() {
        let inputParser: InputParser = DefaultInputParser()
        do {
            try inputParser.parse(input: "a")
            XCTFail()
        } catch let error as InputParsingError {
            XCTAssertEqual(error.kind, InputParsingError.ErrorKind.NoValidEntryFound)
        } catch {
            XCTFail()
        }
    }
}
