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
    
    func testSingleWaveEffectWithBlueRedGreenYellowColors() {
        let inputParser: InputParser = DefaultInputParser()
        let inputString = """
            a,z,e,m,w,x,c,v,b,n
            wave
            blue, red, green, yellow
            """
        XCTAssertNoThrow(try inputParser.parse(input: inputString))
    }
    
    func testSingleDiscoEffectWithGreenYellowBlueColors() {
        let inputParser: InputParser = DefaultInputParser()
        let inputString = """
            a,z,e,m,w,x,c,v,b,n
            disco
            green, yellow, blue
            """
        XCTAssertNoThrow(try inputParser.parse(input: inputString))
    }

    func testThrowsInvalidStaticEffectColorCountError() {
        let inputString = """
        a
        static
        red, green
        """
        let inputParser: InputParser = DefaultInputParser()
        do {
            try inputParser.parse(input: inputString)
            XCTFail()
        } catch let error as InputParsingError {
            XCTAssertEqual(error.kind, InputParsingError.ErrorKind.InvalidColorCount)
        } catch {
            XCTFail()
        }
    }
    
    func testThrowsInvalidDiscoEffectColorCountError() {
        let inputString = """
        a
        disco
        red, green
        """
        let inputParser: InputParser = DefaultInputParser()
        do {
            try inputParser.parse(input: inputString)
            XCTFail()
        } catch let error as InputParsingError {
            XCTAssertEqual(error.kind, InputParsingError.ErrorKind.InvalidColorCount)
        } catch {
            XCTFail()
        }
    }
    
    func testFourValidEntries() {
        let inputString = """
        a, b, c, d
        static
        green
        a, t, v
        static
        red
        d, e, f
        wave
        red, blue
        t, u, v
        disco
        red, green, orange
        """
        let inputParser: InputParser = DefaultInputParser()
        do {
            let result = try inputParser.parse(input: inputString)
            XCTAssertEqual(result.entries.count, 4)
        } catch {
            XCTFail()
        }
    }
    
    static var allTests = [
        ("testEmptyInputThrowsError", testEmptyInputThrowsError),
        ("testEmptyInputThrowsEmptyInputError", testEmptyInputThrowsEmptyInputError),
        ("testThrowsNoValidEntryFoundError", testThrowsNoValidEntryFoundError),
        ("testSingleStaticEffectWithRedColorForOneKeyInput", testSingleStaticEffectWithRedColorForOneKeyInput),
        ("testSingleStaticEffectWithRedColorForTwoKeys", testSingleStaticEffectWithRedColorForTwoKeys),
        ("testSingleStaticEffectWithRedColorForAllKeys", testSingleStaticEffectWithRedColorForAllKeys),
        ("testSingleWaveEffectWithRedColor", testSingleWaveEffectWithRedColor),
        ("testSingleWaveEffectWithBlueRedGreenYellowColors", testSingleWaveEffectWithBlueRedGreenYellowColors),
        ("testSingleDiscoEffectWithGreenYellowBlueColors", testSingleDiscoEffectWithGreenYellowBlueColors),
        ("testThrowsInvalidStaticEffectColorCountError", testThrowsInvalidStaticEffectColorCountError),
        ("testThrowsInvalidDiscoEffectColorCountError", testThrowsInvalidDiscoEffectColorCountError),
        ("testFourValidEntries", testFourValidEntries),
    ]
}
