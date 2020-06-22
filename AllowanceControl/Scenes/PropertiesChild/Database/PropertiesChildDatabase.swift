//
//  PropertiesChildDatabase.swift
//  AllowanceControl
//
//  Created by Helio Junior on 21/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation
import Firebase

final class PropertiesChildDatabase {
    
    private let db = Firestore.firestore()
    private let collectionChild: CollectionReference!
    private var documentId: String!
    
    init(documentId: String) {
        self.documentId = documentId
        collectionChild = db.collection("parents").document("helio@gmail.com").collection("children")
    }
    
    func add(timeline: [Child.Timeline], completion: @escaping (Bool) -> ()) {
        let array = timeline.toArray()
        print("==> ToArray: \(array)")
        collectionChild.document(documentId).updateData([
            "timeline": array
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document Updates")
                completion(true)
            }
        }
    }
}
