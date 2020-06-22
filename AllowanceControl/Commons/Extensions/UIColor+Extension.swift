//
//  UIColor+Extension.swift
//  AllowanceControl
//
//  Created by Helio Junior on 22/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String?) {
        if hex != nil {
            var cString: String = hex!.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if cString.hasPrefix("#") {
                cString.remove(at: cString.startIndex)
            }
            
            if cString.count != 6 {
                self.init(white: 1.0, alpha: 1.0)
            } else {
                var rgbValue: UInt32 = 0
                Scanner(string: cString).scanHexInt32(&rgbValue)
                
                self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
                          green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
                          blue: CGFloat(rgbValue & 0x0000FF) / 255,
                          alpha: 1)
            }
        } else {
            self.init(red: 255, green: 255, blue: 255, alpha: 1)
        }
    }
}
