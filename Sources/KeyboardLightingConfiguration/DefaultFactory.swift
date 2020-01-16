//
//  File.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

class DefaultFactory {
    
}

extension DefaultFactory: Factory {
    func createInputParser() -> InputParser {
        return DefaultInputParser()
    }
    
    func createKeyboardConfiguration() -> KeyboardConfiguration {
        return DefaultKeyboardConfiguration()
    }
    
    func createOutputEncoder() -> OutputEncoder {
        return DefaultOutputEncoder()
    }
    
    
}
