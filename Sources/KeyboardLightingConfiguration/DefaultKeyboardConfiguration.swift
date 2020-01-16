//
//  File.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public class DefaultKeyboardConfiguration {
    public var keyConfigurations = [String : KeyConfiguration]()
}

extension DefaultKeyboardConfiguration: KeyboardConfiguration {
    public func from(entries: InputParsingResult.Entries) {
        if entries.count == 0 {
            return
        }
        keyConfigurations.removeAll()
        let whitespacePattern = "^\\s+|\\s+|\\s+$"
        entries.forEach { (entry) in
            let colorsList = entry.colors.replacingOccurrences(of: whitespacePattern, with: "", options: .regularExpression).split(separator: ",")
            let colors = colorsList.map { (color) -> KeyConfiguration.Color in
                let rawValue = color.prefix(1).capitalized + color.dropFirst()
                return KeyConfiguration.Color(rawValue: rawValue) ?? .Unknown
            }
            entry.keys.replacingOccurrences(of: whitespacePattern, with: "", options: .regularExpression).split(separator: ",").forEach { (key) in
                let rawValue = entry.effect.prefix(1).capitalized + entry.effect.dropFirst()
                guard let effect = KeyConfiguration.Effect(rawValue: rawValue) else {
                    return
                }
                let keyConfiguration = KeyConfiguration(key: String(key), effect: effect, colors: colors)
                keyConfigurations[String(key)] = keyConfiguration
            }
        }
    }
}
