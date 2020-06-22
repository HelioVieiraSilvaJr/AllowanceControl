//
//  ColorPicker.swift
//  AllowanceControl
//
//  Created by Helio Junior on 22/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

struct ColorPicker: Equatable {
    let name: String
    let colorHex: String
    
    static func ==(lhs: ColorPicker, rhs: ColorPicker) -> Bool {
        return lhs.colorHex == rhs.colorHex
    }
}
