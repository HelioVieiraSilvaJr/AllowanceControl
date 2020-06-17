//
//  HomeParticipant.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct HomeParticipant: Identifiable, Codable, Equatable {

    @DocumentID var id: String?
    var name: String
    var nickname: String
    var points: Int
    var timeline: [Timeline]?
    
    struct Timeline: Codable {
        var type: ChangePointsModalViewController.ChangeType
        var points: Int
        var resultPoints: Int
        var description: String?
        var date: String
    }
    
    static func ==(lhs: HomeParticipant, rhs: HomeParticipant) -> Bool {
        return lhs.id == rhs.id
    }
}
