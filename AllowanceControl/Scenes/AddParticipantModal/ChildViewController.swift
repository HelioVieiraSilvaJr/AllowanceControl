//
//  ChildViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

final class ChildViewController: BaseViewController {

    // MARK: Properties
    var didAddParticipant: ((Child) -> Void)?
    
    // MARK: Outlets
    @IBOutlet weak var edtFullName: UITextField!
    @IBOutlet weak var edtNickname: UITextField!
    
    // MARK: Initializate
    static func builder() -> ChildViewController {
        let viewController = ChildViewController.instantiate()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtFullName.becomeFirstResponder()
        
        edtFullName.text = "Helio"
        edtNickname.text = "Helio"
    }
    
    // MARK: Actions
    @IBAction func handlerButtonDone(_ sender: Any) {
        guard validateFields() else { return }
        
        let newParticipant = Child(name: edtFullName.text!, nickname: edtNickname.text!)
        didAddParticipant?(newParticipant)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
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
