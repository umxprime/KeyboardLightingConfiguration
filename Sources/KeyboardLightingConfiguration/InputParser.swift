//
//  InputParser.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public struct InputParsingResult {
    enum Field : String, CaseIterable {
        case Keys
        case Effect
        case Colors
    }
    typealias Entry = [Field:String]
    typealias Entries = [Entry]
    let entries:Entries
    let keyboardConfiguration:KeyboardConfiguration
}

public struct InputParsingError : Error {
    enum ErrorKind {
        case EmptyInput
        case NoValidEntryFound
        case InvalidColorCount
        case Undefined
    }
    
    let kind:ErrorKind
    let message:String?
}

public protocol InputParser {
    @discardableResult
    func parse(input:String) throws -> InputParsingResult
}
