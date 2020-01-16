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
    
    func testSingleStaticEffectWithRedColorForOneKeyInput() {
        let inputParser: InputParser = DefaultInputParser()
        let inputString = """
            a
            static
            red
            """
        XCTAssertNoThrow(try inputParser.parse(input: inputString))
    }
    
    func testSingleStaticEffectWithRedColorForTwoKeys() {
        let inputParser: InputParser = DefaultInputParser()
        let inputString = """
            a, b
            static
            red
            """
        XCTAssertNoThrow(try inputParser.parse(input: inputString))
    }
    
    func testSingleStaticEffectWithRedColorForAllKeys() {
        let inputParser: InputParser = DefaultInputParser()
        let inputString = """
            a,z,e,r,t,y,u,u,i,o,p,q,s,d,f,g,h,j,k,l,m,w,x,c,v,b,n
            static
            red
            """
        XCTAssertNoThrow(try inputParser.parse(input: inputString))
    }
    
    func testSingleWaveEffectWithRedColor() {
        let inputParser: InputParser = DefaultInputParser()
        let inputString = """
            a,z,e,m,w,x,c,v,b,n
            wave
            red
            """
        XCTAssertNoThrow(try inputParser.parse(input: inputString))
    }
    
    func testSingleWaveEffectWithBlueRedGreenColors() {
        let inputParser: InputParser = DefaultInputParser()
        let inputString = """
            a,z,e,m,w,x,c,v,b,n
            wave
            blue, red, green, yellow
            """
        XCTAssertNoThrow(try inputParser.parse(input: inputString))
    }

    static var allTests = [
        ("testEmptyInputThrowsError", testEmptyInputThrowsError),
        ("testEmptyInputThrowsEmptyInputError", testEmptyInputThrowsEmptyInputError),
        ("testThrowsNoValidEntryFoundError", testThrowsNoValidEntryFoundError),
        ("testSingleStaticEffectWithRedColorForOneKeyInput", testSingleStaticEffectWithRedColorForOneKeyInput),
        ("testSingleStaticEffectWithRedColorForTwoKeys", testSingleStaticEffectWithRedColorForTwoKeys),
        ("testSingleStaticEffectWithRedColorForAllKeys", testSingleStaticEffectWithRedColorForAllKeys),
        ("testSingleWaveEffectWithRedColor", testSingleWaveEffectWithRedColor),
        ("testSingleWaveEffectWithBlueRedGreenColors", testSingleWaveEffectWithBlueRedGreenColors),
    ]
}
