//
//  CustomImageView.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

@IBDesignable
final class CustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.updateUI()
    }
    
    @IBInspectable
    var tintImage: UIColor = .black {
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI() {
        tintImage(color: tintImage)
    }
}
