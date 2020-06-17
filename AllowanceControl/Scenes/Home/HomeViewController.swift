//
//  HomeViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class HomeViewBuilder {
    func builder() -> HomeViewController {
        let viewController = HomeViewController.instantiate()
        return viewController
    }
}

final class HomeViewController: BaseViewController {
    
    //MARK: Properties
    var participants: [HomeParticipant] = []

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(UINib(nibName: HomeParticipantCell.identifier, bundle: nil), forCellReuseIdentifier: HomeParticipantCell.identifier)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gerenciador de pontos"
        
        let buttonItemAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlerAddElement))
        navigationItem.rightBarButtonItem = buttonItemAdd
        
        refreshData()
    }
    
    //MARK: Actions
    @objc func handlerAddElement() {
        let vc = AddParticipantModalViewBuilder().builder()
        vc.didAddParticipant = { [weak self] participant in
            self?.participants.append(participant)
            RemoteDatabase.shared.testAddData(name: participant.name, nickname: participant.nickname)
            self?.refreshData()
        }
        present(vc, animated: true, completion: nil)
    }
    
    func refreshData() {
        RemoteDatabase.shared.fetchParticipants { [weak self] participants in
            self?.participants = participants
            self?.reloadTable()
        }
    }
    
    //MARK: Helpers
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: Extensions
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let participant = participants[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeParticipantCell.identifier, for: indexPath) as? HomeParticipantCell {
            cell.setup(with: participant)
            return cell
        }
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let participant = participants[indexPath.row]
        let propertiesViewController = PropertiesParticipantViewBuilder().builder(withParticipant: participant)
        navigationController?.pushViewController(propertiesViewController, animated: true)
    }
}
