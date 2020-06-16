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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
