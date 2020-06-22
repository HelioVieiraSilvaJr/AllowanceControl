//
//  PropertiesChildViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

final class PropertiesChildViewController: BaseViewController {
    
    // MARK: Properties
    var viewModel: PropertiesChildViewModel!
    var shouldUpdateData: (() -> Void)?
    
    // MARK: Initializate
    static func builder(withParticipant child: Child) -> PropertiesChildViewController {
        let viewController = PropertiesChildViewController.instantiate()
        viewController.viewModel = PropertiesChildViewModel(child: child)
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.child.name
        
        let buttonItemEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handlerButtonEdit))
        navigationItem.rightBarButtonItem = buttonItemEdit
    }
    
    // MARK: Actions
    @objc func handlerButtonEdit() {
        print("==> Button Edit")
    }
    
    @IBAction func handlerButtonHistoric(_ sender: Any) {
        print("==> handlerButtonHistoric")
    }
    
    @IBAction func handlerButtonAddPoints(_ sender: Any) {
        let viewController = AddTimelineHistoricViewController.builder(typeTimeline: .addPoints)
        viewController.didCompletion = addNewTimeline
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonRemovePoints(_ sender: Any) {
        let viewController = AddTimelineHistoricViewController.builder(typeTimeline: .removePoints)
        viewController.didCompletion = addNewTimeline
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonPayPoints(_ sender: Any) {
        print("==> handlerButtonPayPoints")
    }
    
    @IBAction func handlerButtonWarn(_ sender: Any) {
        let viewController = AddTimelineHistoricViewController.builder(typeTimeline: .warning)
        viewController.didCompletion = addNewTimeline
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: Helpers
    private func addNewTimeline(_ timeline: Child.Timeline, _ sender: UIViewController) {
        viewModel.addDatabase(timeline) { [weak self] status in
            if status {
                self?.shouldUpdateData?()
                sender.dismiss(animated: true, completion: nil)
                self?.navigationController?.popViewController(animated: true)
            } else {
                print("==> ERROR: Timeline não foi salva!!")
            }
        }
    }
}
