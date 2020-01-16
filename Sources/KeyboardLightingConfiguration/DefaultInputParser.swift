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
            throw InputParsingError(kind: .EmptyInput, message: nil)
        }
        let pattern = #"""
        (?xm)
        ^(?<key>
            (?:[a-z](?-x:$|, *))+)\n
        (?<type>
            (?:static|wave|disco))\n
        (?<color>
            (?:(?:red|green|blue|yellow)(?-x:$|, +))+)
        """#
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        let matches = regex.matches(in: input, options: [], range: range)
        if matches.count == 0 {
            throw InputParsingError(kind: .NoValidEntryFound, message: nil)
        }
        try matches.forEach { (result) in
            var entry = [String:String]()
            for component in ["key", "type", "color"] {
                let componentRange = result.range(withName: component)
                if componentRange.location == NSNotFound {
                    continue
                }
                let inputStartIndex = input.index(input.startIndex, offsetBy: componentRange.lowerBound)
                let inputEndIndex = input.index(input.startIndex, offsetBy: componentRange.upperBound)
                let substring = input[inputStartIndex..<inputEndIndex]
                entry[component] = String(substring)
            }
            guard entry["key"] != nil else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            guard let type = entry["type"] else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            guard let color = entry["color"] else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            if type == "static" {
                if color.split(separator: ",").count > 1 {
                    throw InputParsingError(kind: .InvalidColorCount, message: "INVALID: Static effects are single color only")
                }
            }
        }
    }
}
