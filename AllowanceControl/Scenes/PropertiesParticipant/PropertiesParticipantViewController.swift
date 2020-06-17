//
//  PropertiesParticipantViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class PropertiesParticipantViewBuilder {
    func builder() -> PropertiesParticipantViewController {
        let viewController = PropertiesParticipantViewController.instantiate()
        return viewController
    }
}

final class PropertiesParticipantViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "propriedades"
        
        let buttonItemEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handlerButtonEdit))
        navigationItem.rightBarButtonItem = buttonItemEdit
    }
    
    //MARK: Actions
    @objc func handlerButtonEdit() {
        print("==> Button Edit")
    }
}
