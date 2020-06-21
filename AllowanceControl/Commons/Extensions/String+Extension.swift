//
//  String+Extension.swift
//  AllowanceControl
//
//  Created by Helio Junior on 17/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

extension String {
    
    var integerValue: Int {
        let value = Int(self) ?? 0
        return value
    }
    
    var doubleValue: Double {
        let value = Double(self) ?? 0
        return value
    }
}
