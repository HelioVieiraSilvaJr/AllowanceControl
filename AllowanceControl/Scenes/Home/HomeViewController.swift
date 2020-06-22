//
//  HomeViewController.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: Properties
    var viewModel = HomeViewModel()

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(UINib(nibName: HomeParticipantCell.identifier, bundle: nil), forCellReuseIdentifier: HomeParticipantCell.identifier)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: Initializate
    static func builder() -> HomeViewController {
        let viewController = HomeViewController.instantiate()
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gerenciador de pontos"
        
        let buttonItemTest = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(test))
        let buttonItemTest2 = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(test2))
        
        let buttonItemAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlerAddElement))
        navigationItem.rightBarButtonItems = [buttonItemAdd, buttonItemTest, buttonItemTest2]
        
        bindEvents()
        viewModel.fetchData()
    }
    
    //MARK: Actions
    @objc func handlerAddElement() {
        let vc = ChildViewController.builder(method: .add)
        vc.didAddChild = { [weak self] child in
            self?.viewModel.addChild(child)
        }
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc func test() {
        RemoteDatabase.shared.test1()
    }
    
    @objc func test2() {
        RemoteDatabase.shared.test2()
    }
    
    //MARK: Helpers
    private func bindEvents() {
        viewModel.shouldReloadHome = { [weak self] in
            self?.reloadTable()
        }
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: Extensions
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let child = viewModel.children[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeParticipantCell.identifier, for: indexPath) as? HomeParticipantCell {
            cell.setup(with: child)
            return cell
        }
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let child = viewModel.children[indexPath.row]
        let viewController = PropertiesChildViewController.builder(withParticipant: child)
        viewController.shouldUpdateData = { [weak self] in
            self?.viewModel.fetchData()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
