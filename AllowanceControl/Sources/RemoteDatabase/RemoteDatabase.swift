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
    let collectionParents: CollectionReference!
    let collectionChildren: CollectionReference!
    
    let parent = "helio@gmail.com"
    var data: [String: Any]? {
        didSet {
            if let timeline = data?["timeline"] as? [[String:Any]] {
                var value = 0
                timeline.forEach{ line in
                    if let points = line["points"] as? Int, let type = line["type"] as? String {
                        if type == "add" {
                            value += points
                        } else {
                            value -= points
                        }
                    }
                }
                print("==> RESULTADO VALOR: \(value)")
            }
        }
    }
    
    init() {
        collectionParents = db.collection("parents")
        collectionChildren = collectionParents.document(parent).collection("children")
    }
    
    func addNewParticipant(_ participant: Child) {
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
    
//    func updatePoints(participant: Child) {
//        guard let id = participant.id else {return}
//        // Add a new document with a generated ID
//        db.collection("users").document(id).updateData([
//            "points": participant.points
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            }
//        }
//    }
    
    func addTimeline(id: String, timeline: Child.Timeline) {
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
    
    func test1() {
//        let citiesRef = db.collection("cities")
//
//        citiesRef.document("SF").updateData([
//            "population": 860000
//        ]) { err in
//            if let err = err {
//                print("==> Error adding document: \(err)")
//            }
//        }

//        collectionParents.document(parent).setData([
//            "name": "Helio Vieira",
//            "state": "São Paulo",
//            "city": "Barueri",
//            "country": "Brasil",
//            "timeline": [
//                [
//                    "date": Date().description,
//                    "description": "iashfiashfiuah aif iashf iasuhf ui",
//                    "points": 10,
//                    "type": "add"
//                ],
//                [
//                    "date": Date().description,
//                    "description": "JSduhgc ahfg a",
//                    "points": 5,
//                    "type": "remove"
//                ]
//            ]
//            ])
        
        collectionChildren.addDocument(data: [
        "name": "Heloiza Negrão",
        "nickname": "Helo",
        "timeline": [
            [
                "date": Date().description,
                "description": "Participante adicionado!",
                "points": 0,
                "type": "fisrt"
            ]
        ]
        ])
    }
    
    func test2() {
//        let citiesRef = db.collection("cities")
//        let query = citiesRef.whereField("state", isEqualTo: "CA").getDocuments() { (snap, err) in
//            print("SNAP: \(snap)")
//        }
//
//        print("==> CitiesRef: \(citiesRef)")
//        print("==> Query: \(query)")
        
        
        
//        db.collection("cities").whereField("country", isEqualTo: "USA")
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("==> \(document.documentID) => \(document.data())")
//                    }
//                }
//        }
        
        collectionChildren.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("\n\n -------- TIMELINE -------")
                for document in querySnapshot!.documents {
                    print("---> \(document.documentID) => \(document.data())")
                }
            }
        }
        
        
        let newTimeline: [String:Any] = [
            "date": Date().description,
            "description": "Adicionando novo registro dinamicamente!",
            "points": Int(arc4random_uniform(UInt32(30 - 10 + 1))) + 10,
            "type": Int(arc4random_uniform(UInt32(1 - 0 + 1))) + 0 == 0 ? "remove" : "add"
        ]
        
        guard let data = data else {return}
        print("==> Data: \(data)")
        guard var timeline = data["timeline"] as? [[String:Any]] else {return}
        print("==> Timeline: \(timeline)")
        timeline.append(newTimeline)
        
        
        collectionChildren.document("yRs8whn7F5FAFeh9pVAU").updateData([
            "timeline": timeline
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document Updates")
            }
        }
        
//        db.collection("cities").whereField("capital", isEqualTo: true)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("==> \(document.documentID) => \(document.data())")
//                    }
//                }
//        }
    }
}
