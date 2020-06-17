//
//  RemoteDatabase.swift
//  AllowanceControl
//
//  Created by Helio Junior on 17/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Firebase

class RemoteDatabase {
    
    static let shared = RemoteDatabase()
    let db = Firestore.firestore()
    
    func testAddData(name: String, nickname: String) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name": name,
            "nickname": nickname,
            "points": 0
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func fetchParticipants(completion: @escaping ([HomeParticipant]) -> Void) {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var paticipants = [HomeParticipant]()
                guard let documents = querySnapshot?.documents else {
                    print("==> No documents")
                    return
                }
                paticipants = documents.compactMap { queryDocumentSnapshot -> HomeParticipant? in
                    return try? queryDocumentSnapshot.data(as: HomeParticipant.self)
                }
                completion(paticipants)
            }
        }
    }
}
