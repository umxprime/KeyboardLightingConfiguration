//
//  InputParser.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public struct InputParsingResult {
    public struct Entry: Equatable {
        let keys: String
        let effect: String
        let colors: String
    }
    public typealias Entries = [Entry]
    let entries:Entries
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
