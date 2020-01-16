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
    public func from(inputParsingResult: InputParsingResult) {
        
    }
}
