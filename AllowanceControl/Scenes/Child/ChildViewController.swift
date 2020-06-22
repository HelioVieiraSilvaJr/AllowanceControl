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
    @IBOutlet weak var viewOutside: UIView!
    @IBOutlet weak var viewContent: CustomView!
    @IBOutlet weak var edtFullName: UITextField!
    @IBOutlet weak var edtNickname: UITextField!
    @IBOutlet weak var edtColor: UITextField!
    
    // MARK: Initializate
    static func builder(method: ChildViewModel.Method, child: Child? = nil) -> ChildViewController {
        let viewController = ChildViewController.instantiate()
        viewController.viewModel = ChildViewModel(methodOperation: method, child: child)
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
        
        if viewModel.methodOperation == .update {
            edtFullName.text = viewModel.child?.name
            edtNickname.text = viewModel.child?.nickname
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: Actions
    @IBAction private func handlerButtonDone(_ sender: Any) {
        guard let child = viewModel.validateChild(name: edtFullName.text, nickname: edtNickname.text) else { return }
        
        viewModel.save(child: child) { [weak self] status in
            if status {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction private func handlerButtonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlerTapOutside() {
        self.becomeFirstResponder()
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
        viewContent.backgroundColor = UIColor(hex: color.colorHex)
        edtColor.text = color.name
        viewModel.colorSelected = color
    }
}
