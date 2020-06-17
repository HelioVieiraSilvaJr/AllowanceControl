//
//  UIImageView+Extension.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func tintImage(color: UIColor) {
        guard let image = image else {
            return
        }
        switch image.renderingMode {
        case .alwaysTemplate:
            break
        default:
            self.image = image.withRenderingMode(.alwaysTemplate)
        }
        tintColor = color
    }
}
