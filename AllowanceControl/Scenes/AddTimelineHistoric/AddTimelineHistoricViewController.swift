//
//  AddTimelineHistoricViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 17/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

final class AddTimelineHistoricViewController: UIViewController {
    
    // MARK: Properties
    var didCompletion: ((Child.Timeline, UIViewController) -> Void)?
    var typeTimeline: Child.Timeline.TypeLine = .addPoints
    var points = 1
    
    // MARK: Outlets
    @IBOutlet weak var imgModal: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewChangePoints: UIStackView!
    @IBOutlet weak var txbDescription: UITextView!
    @IBOutlet weak var viewButtonDone: CustomView!
    @IBOutlet weak var edtPoints: UITextField!
    
    // MARK: Initializate
    static func builder(typeTimeline: Child.Timeline.TypeLine) -> AddTimelineHistoricViewController {
        let viewController = AddTimelineHistoricViewController.instantiate()
        viewController.typeTimeline = typeTimeline
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtPoints.addTarget(self, action: #selector(textFieldEndEditing(_:)), for: .editingDidEnd)
        setupViews()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: Actions
    @IBAction func handlerButtonBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonDone() {
        self.becomeFirstResponder()
        let timeline = Child.Timeline(type: typeTimeline, points: points, description: txbDescription.text, date: Date().description)
        didCompletion?(timeline, self)
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
    
    @objc func handlerKeyboardButton() {
        self.becomeFirstResponder()
    }
    
    // MARK: Helpers
    func setupViews() {
        switch typeTimeline {
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
            points = 0
            
        default:
            break
        }
        
        edtPoints.text = points.description
        txbDescription.delegate = self
        
        let keyboardButton = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(handlerKeyboardButton))
        keyboardButton.items = [flexSpace, okButton]
        edtPoints.inputAccessoryView = keyboardButton
        txbDescription.inputAccessoryView = keyboardButton
    }
}

// MARK: Extensions
extension AddTimelineHistoricViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.becomeFirstResponder()
        }
        return true
    }
}
