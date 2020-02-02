//
//  File.swift
//  
//
//  Created by Maxime CHAPELET on 16/01/2020.
//

import Foundation


public typealias OutputEncodingResult = String

public protocol OutputEncoder {
    func encode(configuration: KeyboardConfiguration) -> OutputEncodingResult
}
