//
//  DefaultInputParser.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public class DefaultInputParser {
    
}

extension DefaultInputParser: InputParser {
    public func parse(input: String) throws {
        if (input.isEmpty) {
            throw InputParsingError(kind: .EmptyInput)
        }
        throw InputParsingError(kind: .NoValidEntryFound)
    }
}
