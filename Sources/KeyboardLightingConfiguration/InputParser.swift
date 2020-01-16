//
//  InputParser.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public struct InputParsingError : Error {
    enum ErrorKind {
        case EmptyInput
        case NoValidEntryFound
        case StaticEffectInvalidColorCount
        case Undefined
    }
    
    let kind:ErrorKind
}

public protocol InputParser {
    func parse(input:String) throws
}
