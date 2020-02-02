//
//  frzqgreq.swift
//
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import XCTest
@testable import KeyboardLightingConfiguration

class DefaultOutputEncoderTests: XCTestCase {
    let outputEncoder = DefaultFactory().createOutputEncoder()
    var keyboardConfiguration = DefaultFactory().createKeyboardConfiguration()
    
    override class func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTwoKeyBoardConfigurationMatchTwoLatestEntryWithVariousEffects() {
        keyboardConfiguration.keyConfigurations = [
            "a": KeyConfiguration(key: "a", effect: .Disco, colors: [.Blue, .Green, .Red]),
            "b": KeyConfiguration(key: "b", effect: .Static, colors: [.Red])
        ]
        let outputToMatch = """
        a, disco, [blue, green, red]
        b, static, [red]
        """
        let result = outputEncoder.encode(configuration: keyboardConfiguration)
        XCTAssertEqual(result, outputToMatch)
    }
}
