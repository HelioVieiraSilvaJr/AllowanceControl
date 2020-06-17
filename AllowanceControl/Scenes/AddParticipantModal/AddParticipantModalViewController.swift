//
//  AddParticipantModalViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class AddParticipantModalViewBuilder {
    func builder() -> AddParticipantModalViewController {
        let viewController = AddParticipantModalViewController.instantiate()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }
}

final class AddParticipantModalViewController: BaseViewController {

    //MARK: Properties
    var didAddParticipant: ((HomePartipant) -> Void)?
    
    //MARK: Outlets
    @IBOutlet weak var edtFullName: UITextField!
    @IBOutlet weak var edtNickname: UITextField!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func handlerButtonDone(_ sender: Any) {
        guard validateFields() else { return }
        
        let newParticipant = HomePartipant(fullName: edtFullName.text!, nickname: edtNickname.text!, points: 0)
        didAddParticipant?(newParticipant)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Helpers
    func validateFields() -> Bool {
        var flag = true
        
        if edtFullName.text?.isEmpty ?? true {
            flag = false
        }
        if edtNickname.text?.isEmpty ?? true {
            flag = false
        }
        
        return flag
    }
}
