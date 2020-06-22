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
    var child: Child!
    var shouldUpdateData: (() -> Void)?
    
    // MARK: Initializate
    static func builder(withParticipant participant: Child) -> PropertiesChildViewController {
        let viewController = PropertiesChildViewController.instantiate()
        viewController.child = participant
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = child.name
        
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
        let viewController = ChangePointsModalViewController.builder(changeType: .addPoints)
        viewController.didChangeCompletion = didChangePoints
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonRemovePoints(_ sender: Any) {
        let viewController = ChangePointsModalViewController.builder(changeType: .removePoints)
        viewController.didChangeCompletion = didChangePoints
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonPayPoints(_ sender: Any) {
        print("==> handlerButtonPayPoints")
    }
    
    @IBAction func handlerButtonWarn(_ sender: Any) {
        let viewController = ChangePointsModalViewController.builder(changeType: .warning)
        viewController.didChangeCompletion = didChangePoints
        present(viewController, animated: true, completion: nil)
    }
    
    // MARK: Helpers
    private func didChangePoints(_ changePoint: Child.Timeline) {
        guard let id = child.id else { return }
        child.timeline?.append(changePoint)
        var changePoint = changePoint
        
//        switch changePoint.type {
//        case .addPoints:
//            participant.points += changePoint.points
//
//        case .removePoints:
//            participant.points -= changePoint.points
//
//        default:
//            changePoint.points = 0
//        }
//
//        changePoint.resultPoints = participant.points
        changePoint.date = Date().description
//        RemoteDatabase.shared.updatePoints(participant: child)
        RemoteDatabase.shared.addTimeline(id: id, timeline: changePoint)
        shouldUpdateData?()
        navigationController?.popViewController(animated: true)
    }
}
