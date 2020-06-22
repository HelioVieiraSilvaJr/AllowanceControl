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
    var methodOpetarion: Method = .add
    var child: Child?
    var didAddChild: ((Child) -> Void)?
    var didEditChild: ((Child) -> Void)?
    private var colorSelected: ColorPicker? {
        didSet{
            viewContent.backgroundColor = UIColor(hex: colorSelected?.colorHex)
        }
    }
    private let pickerData: [ColorPicker] = [
        ColorPicker(name: "padrão", colorHex: "F2F2F7"),
        ColorPicker(name: "azul", colorHex: "85E3FF"),
        ColorPicker(name: "azul pastel", colorHex: "ACE7FF"),
        ColorPicker(name: "verde", colorHex: "BFFCC6"),
        ColorPicker(name: "verde pastel", colorHex: "DBFFD6"),
        ColorPicker(name: "vermelho", colorHex: "FFABAB"),
        ColorPicker(name: "vermelho pastel", colorHex: "FFCBC1"),
        ColorPicker(name: "rosa", colorHex: "F6A6FF"),
        ColorPicker(name: "rosa pastel", colorHex: "FCC2FF"),
        ColorPicker(name: "amarelo", colorHex: "FFF5BA"),
        ColorPicker(name: "amarelo pastel", colorHex: "FFFFD1")
    ]
    private var pickerColor = UIPickerView()
    enum Method {
        case add
        case edit
    }

    // MARK: Outlets
    @IBOutlet weak var viewOutside: UIView!
    @IBOutlet weak var viewContent: CustomView!
    @IBOutlet weak var edtFullName: UITextField!
    @IBOutlet weak var edtNickname: UITextField!
    @IBOutlet weak var edtColor: UITextField!
    
    // MARK: Initializate
    static func builder(method: Method, child: Child? = nil) -> ChildViewController {
        let viewController = ChildViewController.instantiate()
        viewController.child = child
        viewController.methodOpetarion = method
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
        
        edtColor.inputView = pickerColor
        pickerColor.dataSource = self
        pickerColor.delegate = self
        
        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(handlerTapOutside))
        viewOutside.addGestureRecognizer(tapOutside)
        
        if methodOpetarion == .add {
            let random = Int.random(in: 0..<pickerData.count)
            colorSelected = pickerData[random]
        }
        else {
            edtFullName.text = child?.name
            edtNickname.text = child?.nickname
            colorSelected = pickerData.filter({ $0.colorHex == child?.colorHex }).first
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: Actions
    @IBAction private func handlerButtonDone(_ sender: Any) {
        guard validateFields() else { return }
        
        if methodOpetarion == .add {
            let newChild = Child(name: edtFullName.text!, nickname: edtNickname.text!, colorHex: colorSelected?.colorHex)
            didAddChild?(newChild)
        }
        else {
             let child = Child(name: edtFullName.text!, nickname: edtNickname.text!, colorHex: colorSelected?.colorHex)
            didEditChild?(child)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func handlerButtonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlerTapOutside() {
        self.becomeFirstResponder()
    }
    
    // MARK: Helpers
    private func validateFields() -> Bool {
        var flag = true
        
        if edtFullName.text?.isEmpty ?? true {
            flag = false
        }
        if edtNickname.text?.isEmpty ?? true {
            flag = false
        }
        if colorSelected == nil {
            flag = false
        }
        
        return flag
    }
}


extension ChildViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let color = pickerData[row]
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        view.backgroundColor = UIColor(hex: color.colorHex)
        let label = UILabel()
        view.addSubview(label)
        label.text = color.name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let color = pickerData[row]
        viewContent.backgroundColor = UIColor(hex: color.colorHex)
        edtColor.text = color.name
        colorSelected = color
    }
}
