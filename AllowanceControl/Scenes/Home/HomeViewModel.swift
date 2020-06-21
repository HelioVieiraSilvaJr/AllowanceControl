//
//  HomeViewModel.swift
//  AllowanceControl
//
//  Created by Helio Junior on 21/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    // MARK: Properties
    var children: [Child] = []
    var shouldReloadHome: (() -> ())?
    
    let database = HomeDatabase()
    
    func fetchData() {
        database.fetchChildren { [weak self] children in
            self?.children = children
            self?.shouldReloadHome?()
        }
    }
    
}
