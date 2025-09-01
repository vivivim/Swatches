//
//  Swatch.swift
//  Swatches
//
//  Created by Admin on 8/27/25.
//

import Foundation
import SwiftData

@Model
class Swatch: Identifiable {
    var id = UUID()
    var title: String
    var yarn: String
    var needle: String
    
    var type: SwatchType
    
    var stitch: String
    var row: String
    
    var width: String
    var height: String
    
    init(title: String, yarn: String, needle: String, type: SwatchType, stitch: String, row: String, width: String, height: String) {
        self.title = title
        self.yarn = yarn
        self.needle = needle
        self.type = type
        self.stitch = stitch
        self.row = row
        self.width = width
        self.height = height
    }
}

enum SwatchType: String, Codable {
    case stocking
    case pattern
}
