//
//  PropertiesParticipantViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class PropertiesParticipantViewBuilder {
    func builder(withParticipant participant: HomeParticipant) -> PropertiesParticipantViewController {
        let viewController = PropertiesParticipantViewController.instantiate()
        viewController.participant = participant
        return viewController
    }
}

final class PropertiesParticipantViewController: BaseViewController {
    
    //MARK: Properties
    var participant: HomeParticipant!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = participant.name
        
        let buttonItemEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handlerButtonEdit))
        navigationItem.rightBarButtonItem = buttonItemEdit
    }
    
    //MARK: Actions
    @objc func handlerButtonEdit() {
        print("==> Button Edit")
    }
    
    @IBAction func handlerButtonHistoric(_ sender: Any) {
        print("==> handlerButtonHistoric")
    }
    
    @IBAction func handlerButtonAddPoints(_ sender: Any) {
        print("==> handlerButtonAddPoints")
    }
    
    @IBAction func handlerButtonRemovePoints(_ sender: Any) {
        print("==> handlerButtonRemovePoints")
    }
    
    @IBAction func handlerButtonPayPoints(_ sender: Any) {
        print("==> handlerButtonPayPoints")
    }
    
    @IBAction func handlerButtonWarn(_ sender: Any) {
        print("==> handlerButtonWarn")
    }
    
}
