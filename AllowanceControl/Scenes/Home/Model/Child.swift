//
//  Child.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct Child: Identifiable, Codable, Equatable {

    @DocumentID var id: String?
    var name: String
    var nickname: String
    var timeline: [Timeline]?
    var colorHex: String?
    
    struct Timeline: Codable {
        enum TypeLine: String, Codable {
            case create
            case addPoints
            case removePoints
            case warning
            case unknow
            
            init(from decoder: Decoder) throws {
                self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknow
            }
        }
        
        var type: TypeLine = .unknow
        var points: Int?
        var description: String?
        var date: String
    }
    
    static func ==(lhs: Child, rhs: Child) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Child {
 
    func getPoints() -> Int {
        guard let timeline = timeline else {return 0}
        
        var resultValue = 0
        timeline.forEach{ line in
            if let points = line.points {
                switch line.type {
                case .addPoints:
                    resultValue += points
                case .removePoints:
                    resultValue -= points
                default:
                    break
                }
            }
        }
        return resultValue
    }
}
