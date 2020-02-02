//
//  frzqgreq.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import XCTest
@testable import KeyboardLightingConfiguration

class DefaultKeyboardConfigurationTests: XCTestCase {
    let keyboardConfiguration = DefaultFactory().createKeyboardConfiguration()
    
    override class func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKeyBoardConfigurationCountFromOneEntry() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "red"))
        keyboardConfiguration.from(entries: entries)
        XCTAssertEqual(keyboardConfiguration.keyConfigurations.count, 1)
    }
    
    func testKeyBoardConfigurationMatchOneEntry() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "red"))
        keyboardConfiguration.from(entries: entries)
        let keyConfigurationToMatch = KeyConfiguration(key: "a", effect: .Static, colors: [.Red])
        XCTAssertEqual(keyboardConfiguration.keyConfigurations, ["a":keyConfigurationToMatch])
    }
}
