//
//  File.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation

public protocol Factory {
    func createInputParser() -> InputParser
    func createKeyboardConfiguration() -> KeyboardConfiguration
    func createOutputEncoder() -> OutputEncoder
}
