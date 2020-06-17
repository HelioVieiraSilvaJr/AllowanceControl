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
    var participants: [HomePartipant] = []

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
        
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlerAddElement))
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    //MARK: Actions
    @objc
    func handlerAddElement() {
        let vc = AddParticipantModalViewBuilder().builder()
        vc.didAddParticipant = { [weak self] participant in
            self?.participants.append(participant)
            self?.reloadTable()
        }
        present(vc, animated: true, completion: nil)
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
        
        print("==> Select Participant: \(participant)")
    }
}
