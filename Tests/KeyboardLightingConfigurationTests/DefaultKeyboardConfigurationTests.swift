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
    
    func testOneKeyBoardConfigurationCountFromTwoEntries() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "red"))
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "blue"))
        keyboardConfiguration.from(entries: entries)
        XCTAssertEqual(keyboardConfiguration.keyConfigurations.count, 1)
    }
    
    func testTwoKeyBoardConfigurationCountFromThreeEntries() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "red"))
        entries.append(InputParsingResult.Entry(keys: "a, b", effect: "static", colors: "blue"))
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "green"))
        keyboardConfiguration.from(entries: entries)
        XCTAssertEqual(keyboardConfiguration.keyConfigurations.count, 2)
    }
    
    func testKeyBoardConfigurationMatchOneEntry() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "red"))
        keyboardConfiguration.from(entries: entries)
        let keyConfigurationToMatch = KeyConfiguration(key: "a", effect: .Static, colors: [.Red])
        XCTAssertEqual(keyboardConfiguration.keyConfigurations, ["a":keyConfigurationToMatch])
    }
    
    func testOneKeyBoardConfigurationMatchLatestEntry() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "red"))
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "blue"))
        keyboardConfiguration.from(entries: entries)
        let keyConfigurationToMatch = KeyConfiguration(key: "a", effect: .Static, colors: [.Blue])
        XCTAssertEqual(keyboardConfiguration.keyConfigurations, ["a":keyConfigurationToMatch])
    }
    
    func testTwoKeyBoardConfigurationMatchTwoLatestEntry() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "static", colors: "red"))
        entries.append(InputParsingResult.Entry(keys: "a, b", effect: "static", colors: "blue"))
        entries.append(InputParsingResult.Entry(keys: "b", effect: "static", colors: "red"))
        keyboardConfiguration.from(entries: entries)
        let keyConfigurationsToMatch = [
            "a": KeyConfiguration(key: "a", effect: .Static, colors: [.Blue]),
            "b": KeyConfiguration(key: "b", effect: .Static, colors: [.Red])
        ]
        XCTAssertEqual(keyboardConfiguration.keyConfigurations, keyConfigurationsToMatch)
    }
    
    func testTwoKeyBoardConfigurationMatchTwoLatestEntryWithVariousEffects() {
        var entries = InputParsingResult.Entries()
        entries.append(InputParsingResult.Entry(keys: "a", effect: "wave", colors: "red, orange"))
        entries.append(InputParsingResult.Entry(keys: "a, b", effect: "disco", colors: "blue, green, red"))
        entries.append(InputParsingResult.Entry(keys: "b", effect: "static", colors: "red"))
        keyboardConfiguration.from(entries: entries)
        let keyConfigurationsToMatch = [
            "a": KeyConfiguration(key: "a", effect: .Disco, colors: [.Blue, .Green, .Red]),
            "b": KeyConfiguration(key: "b", effect: .Static, colors: [.Red])
        ]
        XCTAssertEqual(keyboardConfiguration.keyConfigurations, keyConfigurationsToMatch)
    }
}
