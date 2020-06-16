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

    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Gerenciador de pontos"
        
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlerAddElement))
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc
    func handlerAddElement() {
        print("==> Add Element..")
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("==> Select Index: \(indexPath.row)")
    }
}
