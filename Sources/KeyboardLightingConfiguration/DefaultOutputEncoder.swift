//
//  File.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public class DefaultOutputEncoder {
    
}

extension DefaultOutputEncoder: OutputEncoder {
    public func encode(configuration: KeyboardConfiguration) -> OutputEncodingResult {
        var output = [String]()
        if configuration.keyConfigurations.count == 0 {
            return ""
        }
        configuration.keyConfigurations.values.sorted { (lhs, rhs) in
            lhs.key < rhs.key
        }.forEach { (keyConfiguration) in
            let line = """
            \(keyConfiguration.key), \
            \(keyConfiguration.effect.rawValue.lowercased()), \
            [\(keyConfiguration.colors.map{$0.rawValue.lowercased()}.joined(separator: ", "))]
            """
            output.append(line)
        }
        return output.joined(separator: "\n")
    }
}
