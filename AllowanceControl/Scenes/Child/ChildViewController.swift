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
    var viewModel: ChildViewModel!
    var didFinish: (() -> Void)?
    private var pickerColor = UIPickerView()
    
    // MARK: Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtNickname: UITextField!
    @IBOutlet weak var edtColor: UITextField!
    
    // MARK: Initializate
    static func builder(method: ChildViewModel.Method, child: Child? = nil) -> ChildViewController {
        let viewController = ChildViewController.instantiate()
        viewController.viewModel = ChildViewModel(methodOperation: method, child: child)
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtName.becomeFirstResponder()
        
        edtColor.inputView = pickerColor
        pickerColor.dataSource = self
        pickerColor.delegate = self
        
        if viewModel.methodOperation == .add {
            lblTitle.text = "Adicionar participante"
        } else {
            lblTitle.text = "Editar participante"
            edtName.text = viewModel.child?.name
            edtNickname.text = viewModel.child?.nickname
            edtColor.text = viewModel.colorSelected?.name
            edtColor.backgroundColor = UIColor(hex: viewModel.child?.colorHex)
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: Actions
    @IBAction private func handlerButtonDone(_ sender: Any) {
        guard let child = viewModel.validateChild(name: edtName.text, nickname: edtNickname.text) else { return }
        
        viewModel.save(child: child) { [weak self] status in
            if status {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

// MARK: Extensions
extension ChildViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.colorsData.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let color = viewModel.colorsData[row]
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
        let color = viewModel.colorsData[row]
        edtColor.backgroundColor = UIColor(hex: color.colorHex)
        edtColor.text = color.name
        viewModel.colorSelected = color
    }
}