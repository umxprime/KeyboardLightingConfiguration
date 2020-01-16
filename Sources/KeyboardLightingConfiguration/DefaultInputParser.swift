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
        if input.isEmpty {
            throw InputParsingError(kind: .EmptyInput)
        }
        let pattern = #"""
        (?xm)
        ^(?<key>
            (?:[a-z](?-x:$|, *))+)\n
        (?<type>
            static)\n
        (?<color>
            red)
        """#
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        let matches = regex.matches(in: input, options: [], range: range)
        if matches.count == 0 {
            throw InputParsingError(kind: .NoValidEntryFound)
        }
    }
}
