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
    var didAddParticipant: ((_ name: String?, _ nickname: String?) -> Void)?
    
    //MARK: Outlets
    @IBOutlet weak var edtFullName: UITextField!
    @IBOutlet weak var edtNickname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func handlerButtonDone(_ sender: Any) {
        didAddParticipant?(edtFullName.text, edtNickname.text)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
