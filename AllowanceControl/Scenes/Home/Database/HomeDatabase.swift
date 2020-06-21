//
//  HomeDatabase.swift
//  AllowanceControl
//
//  Created by Helio Junior on 21/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation
import Firebase

final class HomeDatabase {
    
    let db = Firestore.firestore()
    let collectionChields: CollectionReference!
    
    init() {
        collectionChields =  db.collection("parents").document("helio@gmail.com").collection("chields")
    }
    
    func fetchParticipants(completion: @escaping ([Child]) -> Void) {
        collectionChields.addSnapshotListener { documentSnapshot, error in
            if let err = error {
                print("==> Error getting documents: \(err)")
            } else {
                var participants = [Child]()
                guard let documents = documentSnapshot?.documents else {
                    print("==> No documents")
                    return
                }
                participants = documents.compactMap { queryDocumentSnapshot -> Child? in
                    return try? queryDocumentSnapshot.data(as: Child.self)
                }
                completion(participants)
            }
        }
    }
    
}
