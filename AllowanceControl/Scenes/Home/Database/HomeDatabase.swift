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
    let collectionChieldren: CollectionReference!
    
    init() {
        collectionChieldren =  db.collection("parents").document("helio@gmail.com").collection("children")
    }
    
    func fetchChildren(completion: @escaping ([Child]) -> Void) {
        collectionChieldren.addSnapshotListener { documentSnapshot, error in
            if let err = error {
                print("==> Error getting documents: \(err)")
            } else {
                var children = [Child]()
                guard let documents = documentSnapshot?.documents else {
                    print("==> No documents")
                    return
                }
                children = documents.compactMap { queryDocumentSnapshot -> Child? in
                    print("==> Try Child: \(queryDocumentSnapshot.data())")
                    return try? queryDocumentSnapshot.data(as: Child.self)
                }
                print("==> Child: \(children)")
                completion(children)
            }
        }
    }
}
