//
//  DefaultInputParser.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public class DefaultInputParser {
    enum Field : String, CaseIterable {
        case Keys
        case Effect
        case Colors
    }
    
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
    
    let factory: Factory
    
    public init(factory: Factory) {
        self.factory = factory
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
        ^(?<\#(Field.Keys.rawValue)>
            (?:[a-z](?-x:$|, *))+)\n
        (?<\#(Field.Effect.rawValue)>
            (?:\#(effects)))\n
        (?<\#(Field.Colors.rawValue)>
            (?:(?:\#(colors))(?-x:$|, +))+$)
        """#
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        let matches = regex.matches(in: input, options: [], range: range)
        if matches.count == 0 {
            throw InputParsingError(kind: .NoValidEntryFound, message: nil)
        }
        try matches.forEach { (result) in
            var fields = [Field:String]()
            for field in Field.allCases {
                let fieldRange = result.range(withName: field.rawValue)
                if fieldRange.location == NSNotFound {
                    continue
                }
                let inputStartIndex = input.index(input.startIndex, offsetBy: fieldRange.lowerBound)
                let inputEndIndex = input.index(input.startIndex, offsetBy: fieldRange.upperBound)
                let substring = input[inputStartIndex..<inputEndIndex]
                fields[field] = String(substring)
            }
            guard let rawKeys = fields[.Keys] else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            guard let rawEffect = fields[.Effect] else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            guard let effect = Effect(rawValue: rawEffect.prefix(1).capitalized + rawEffect.dropFirst()) else {
                throw InputParsingError(kind: .Undefined, message: "INVALID: Invalid effect \(rawEffect)")
            }
            guard let rawColors = fields[.Colors] else {
                throw InputParsingError(kind: .Undefined, message: nil)
            }
            
            switch effect {
            case .Static:
                if rawColors.split(separator: ",").count > 1 {
                    throw InputParsingError(kind: .InvalidColorCount, message: "INVALID: Static effects are single color only")
                }
            case .Disco:
                if rawColors.split(separator: ",").count != 3 {
                    throw InputParsingError(kind: .InvalidColorCount, message: "INVALID: Disco effects are three color only")
                }
            case .Wave:
                break
            }
            let entry = InputParsingResult.Entry(keys: rawKeys, effect: rawEffect, colors: rawColors)
            entries.append(entry)
        }
        let keyboardConfiguration = factory.createKeyboardConfiguration()
        keyboardConfiguration.from(entries: entries)
        return InputParsingResult(entries: entries, keyboardConfiguration: factory.createKeyboardConfiguration())
    }
}
