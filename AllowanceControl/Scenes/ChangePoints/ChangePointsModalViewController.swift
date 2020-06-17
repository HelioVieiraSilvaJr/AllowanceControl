//
//  ChangePointsModalViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 17/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class ChangePointsModalViewBuilder {
    func builder(changeType: ChangePointsModalViewController.ChangeType) -> ChangePointsModalViewController {
        let viewController = ChangePointsModalViewController.instantiate()
        viewController.changeType = changeType
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }
}

final class ChangePointsModalViewController: UIViewController {
    
    //MARK: Properties
    var didChangeCompletion: ((HomeParticipant.Timeline) -> Void)?
    enum ChangeType: String, Codable {
        case addPoints
        case removePoints
        case warning
    }
    var changeType: ChangeType = .addPoints
    var points = 1
    
    //MARK: Outlets
    @IBOutlet weak var imgModal: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewChangePoints: UIStackView!
    @IBOutlet weak var txbDescription: UITextView!
    @IBOutlet weak var viewButtonDone: CustomView!
    @IBOutlet weak var edtPoints: UITextField!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtPoints.addTarget(self, action: #selector(textFieldEndEditing(_:)), for: .editingDidEnd)
        configureView()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: Actions
    @IBAction func handlerButtonBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonDone() {
        self.becomeFirstResponder()
        let timeline = HomeParticipant.Timeline(type: changeType, points: points, resultPoints: 0, description: txbDescription.text, date: "")
        didChangeCompletion?(timeline)
        handlerButtonBack()
    }
    
    @IBAction func handlerMore() {
        points += 1
        edtPoints.text = points.description
    }
    
    @IBAction func handlerMinus() {
        points -= 1
        edtPoints.text = points.description
    }
    
    @objc func textFieldEndEditing(_ textField: UITextField) {
        points = textField.text?.integerValue ?? 0
    }
    
    //MARK: Helpers
    func configureView() {
        edtPoints.text = points.description
        
        switch changeType {
        case .addPoints:
            imgModal.image = UIImage(named: "icPlusPoints")
            lblTitle.text = "ganhou pontos"
            let color = UIColor(red: 0, green: 143/255, blue: 0, alpha: 1)
            lblTitle.textColor = color
            edtPoints.textColor = color
            viewButtonDone.backgroundColor = color
            
        case .removePoints:
            imgModal.image = UIImage(named: "icRemovePoints")
            lblTitle.text = "perdeu pontos"
            let color = UIColor(red: 148/255, green: 17/255, blue: 0, alpha: 1)
            lblTitle.textColor = color
            edtPoints.textColor = color
            viewButtonDone.backgroundColor = color
            
        case .warning:
            imgModal.image = UIImage(named: "icWarning")
            lblTitle.text = "recebeu uma advertência"
            viewChangePoints.isHidden = true
            let color = UIColor(red: 146/255, green: 144/255, blue: 0, alpha: 1)
            lblTitle.textColor = color
            edtPoints.textColor = color
            viewButtonDone.backgroundColor = color
        }
    }
}

//MARK: Extensions
