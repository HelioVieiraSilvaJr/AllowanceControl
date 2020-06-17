//
//  PropertiesParticipantViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class PropertiesParticipantViewBuilder {
    func builder(withParticipant participant: HomeParticipant) -> PropertiesParticipantViewController {
        let viewController = PropertiesParticipantViewController.instantiate()
        viewController.participant = participant
        return viewController
    }
}

final class PropertiesParticipantViewController: BaseViewController {
    
    //MARK: Properties
    var participant: HomeParticipant!
    var shouldUpdateData: (() -> Void)?
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = participant.name
        
        let buttonItemEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handlerButtonEdit))
        navigationItem.rightBarButtonItem = buttonItemEdit
    }
    
    //MARK: Actions
    @objc func handlerButtonEdit() {
        print("==> Button Edit")
    }
    
    @IBAction func handlerButtonHistoric(_ sender: Any) {
        print("==> handlerButtonHistoric")
    }
    
    @IBAction func handlerButtonAddPoints(_ sender: Any) {
        let viewController = ChangePointsModalViewBuilder().builder(changeType: .addPoints)
        viewController.didChangeCompletion = didChangePoints
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonRemovePoints(_ sender: Any) {
        let viewController = ChangePointsModalViewBuilder().builder(changeType: .removePoints)
        viewController.didChangeCompletion = didChangePoints
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func handlerButtonPayPoints(_ sender: Any) {
        print("==> handlerButtonPayPoints")
    }
    
    @IBAction func handlerButtonWarn(_ sender: Any) {
        let viewController = ChangePointsModalViewBuilder().builder(changeType: .warning)
        viewController.didChangeCompletion = didChangePoints
        present(viewController, animated: true, completion: nil)
    }
    
    //MARK: Helpers
    private func didChangePoints(_ changePoint: HomeParticipant.Timeline) {
        guard let id = participant.id else { return }
        participant.timeline?.append(changePoint)
        var changePoint = changePoint
        
        switch changePoint.type {
        case .addPoints:
            participant.points += changePoint.points
            
        case .removePoints:
            participant.points -= changePoint.points
            
        case .warning:
            changePoint.points = 0
            break
        }
        
        changePoint.resultPoints = participant.points
        changePoint.date = Date().description
        RemoteDatabase.shared.updatePoints(participant: participant)
        RemoteDatabase.shared.addTimeline(id: id, timeline: changePoint)
        shouldUpdateData?()
        navigationController?.popViewController(animated: true)
    }
}
