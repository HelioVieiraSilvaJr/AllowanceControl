//
//  PropertiesChildViewModel.swift
//  AllowanceControl
//
//  Created by Helio Junior on 21/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

final class PropertiesChildViewModel {
    
    var database: PropertiesChildDatabase!
    var child: Child!
    
    init(child: Child) {
        self.child = child
        database = PropertiesChildDatabase(documentId: child.id!)
    }
    
    func addDatabase(_ timeline: Child.Timeline, completion: @escaping (Bool) -> ()) {
        guard var childTimeline = child.timeline else {return}
        
        childTimeline.append(timeline)
        database.add(timeline: childTimeline, completion: completion)
    }
    
    func updateChild(_ child: Child) {
        print("==> Update Child: \(child)")
    }
}
