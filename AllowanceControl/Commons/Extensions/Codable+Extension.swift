//
//  Codable+Extension.swift
//  AllowanceControl
//
//  Created by Helio Junior on 21/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toJSON() -> [String: Any] {
        do{
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch let err {
            print("ERROR: \(err.localizedDescription)")
            return [:]
        }
    }
    
    func toArray() -> [[String: Any]] {
        do{
            let data = try JSONEncoder().encode(self)
            guard let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] else {
                return []
            }
            return array
        } catch let err {
            print("ERROR: \(err.localizedDescription)")
            return []
        }
    }
}
