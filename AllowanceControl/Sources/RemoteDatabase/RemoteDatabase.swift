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
    
    func fetchParticipants(completion: @escaping ([HomeParticipant]) -> Void) {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var participants = [HomeParticipant]()
                guard let documents = querySnapshot?.documents else {
                    print("==> No documents")
                    return
                }
                participants = documents.compactMap { queryDocumentSnapshot -> HomeParticipant? in
                    return try? queryDocumentSnapshot.data(as: HomeParticipant.self)
                }
                completion(participants)
            }
        }
    }
    
    func addNewParticipant(_ participant: HomeParticipant) {
        // Add a new document with a generated ID
        db.collection("users").addDocument(data: [
            "name": participant.name,
            "nickname": participant.nickname,
            "points": 0
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
    }
    
    func updatePoints(participant: HomeParticipant) {
        guard let id = participant.id else {return}
        // Add a new document with a generated ID
        db.collection("users").document(id).updateData([
            "points": participant.points
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
    }
    
    func addTimeline(id: String, timeline: HomeParticipant.Timeline) {
        do {
            let timelineData = try JSONEncoder().encode(timeline)
            guard let dictionary = try JSONSerialization.jsonObject(with: timelineData, options: .allowFragments) as? [String:Any] else {return}
            
            db.collection("users").document(id).collection("timeline").addDocument(data: dictionary) { err in
                if let err = err {
                    print("Error adding timeline: \(err)")
                }
            }
        } catch let err {
            print("Error: \(err.localizedDescription)")
        }
    }
    
    
    //---------- TEST's ----------
    
    func testAddPoint(id: String, data: [String:Any]) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").document(id).collection("timeline").addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    
    func testRead(id: String) {
        db.collection("users").document(id).collection("timeline").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("\n\n -------- TIMELINE -------")
                for document in querySnapshot!.documents {
                    print("---> \(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func testUpdate(id: String) {
        // Add a new document with a generated ID
        db.collection("users").document(id).updateData([
            "points": 14
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document Updates")
            }
        }
    }
}
