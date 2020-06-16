//
//  UIViewController+Extension.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate(viewController: String? = nil, storyboard: String? = nil) -> Self {
        let viewController = viewController ?? String(describing: Self.self)
        let storyboard = storyboard ?? String(describing: Self.self)
        
        let storyboardInstance = UIStoryboard(name: storyboard, bundle: Bundle.main)
        guard let viewControllerInstance = storyboardInstance.instantiateViewController(withIdentifier: viewController) as? Self else {
            fatalError("ERROR: Invalid instance ViewController \"\(viewController)\"" )
        }
        
        return viewControllerInstance
    }
}
