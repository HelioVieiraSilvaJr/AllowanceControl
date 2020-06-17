//
//  CustomView.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

@IBDesignable
final class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.updateUI()
    }
    
    @IBInspectable var corner: CGFloat = 8 {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        layer.cornerRadius = corner
    }
}
