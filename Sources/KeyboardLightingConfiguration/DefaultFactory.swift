//
//  File.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public class DefaultFactory {
    public init() {
        
    }
}

extension DefaultFactory: Factory {
    public func createInputParser() -> InputParser {
        return DefaultInputParser()
    }
    
    public func createKeyboardConfiguration() -> KeyboardConfiguration {
        return DefaultKeyboardConfiguration()
    }
    
    public func createOutputEncoder() -> OutputEncoder {
        return DefaultOutputEncoder()
    }
    
    
}
