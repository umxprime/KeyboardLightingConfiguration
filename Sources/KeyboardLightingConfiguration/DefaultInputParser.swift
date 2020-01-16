//
//  DefaultInputParser.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public class DefaultInputParser {
    enum Effect : String, CaseIterable {
        case Static
        case Wave
        case Disco
    }
    
    enum Color: String, CaseIterable {
        case Red
        case Green
        case Blue
        case Yellow
        case Orange
    }
}

extension DefaultInputParser: InputParser {
    public func parse(input: String) throws -> InputParsingResult {
        var entries = InputParsingResult.Entries()
        if input.isEmpty {
            throw InputParsingError(kind: .EmptyInput, message: nil)
        }
        let effects = Effect.allCases.map { return $0.rawValue.lowercased() }.joined(separator: "|")
        let colors = Color.allCases.map { return $0.rawValue.lowercased() }.joined(separator: "|")
        let pattern = #"""
        (?xm)
        ^(?<key>
            (?:[a-z](?-x:$|, *))+)\n
        (?<type>
            (?:\#(effects)))\n
        (?<color>
            (?:(?:\#(colors))(?-x:$|, +))+$)
        """#
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        let matches = regex.matches(in: input, options: [], range: range)
        if matches.count == 0 {
            throw InputParsingError(kind: .NoValidEntryFound, message: nil)
        }
        try matches.forEach { (result) in
            var entry = InputParsingResult.Entry()
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
            guard let rawEffectType = entry["type"] else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            guard let effectType = Effect(rawValue: rawEffectType.prefix(1).capitalized + rawEffectType.dropFirst()) else {
                throw InputParsingError(kind: .Undefined, message: "INVALID: Invalid effect \(rawEffectType)")
            }
            guard let color = entry["color"] else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            
            switch effectType {
            case .Static:
                if color.split(separator: ",").count > 1 {
                    throw InputParsingError(kind: .InvalidColorCount, message: "INVALID: Static effects are single color only")
                }
            case .Disco:
                if color.split(separator: ",").count != 3 {
                    throw InputParsingError(kind: .InvalidColorCount, message: "INVALID: Disco effects are three color only")
                }
            case .Wave:
                break
            }
            entries.append(entry)
        }
        return InputParsingResult(entries: entries)
    }
}
