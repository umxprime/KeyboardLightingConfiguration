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
    public func encode(configuration: KeyboardConfiguration) throws -> OutputEncodingResult {
        return ""
    }
}
