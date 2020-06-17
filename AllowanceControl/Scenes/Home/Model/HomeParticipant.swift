//
//  HomeParticipant.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct HomeParticipant: Identifiable, Codable {

    @DocumentID var id: String?
    var name: String
    var nickname: String
    var points: Int
}
