//
//  ChildDatabase.swift
//  AllowanceControl
//
//  Created by Helio Junior on 22/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Firebase

final class ChildDatabase {
    
    let db = Firestore.firestore()
    let collectionChildren: CollectionReference!
    
    init() {
        collectionChildren = db.collection("parents").document("helio@gmail.com").collection("children")
    }
    
    func addDatabase(child: Child, completion: @escaping(Bool) -> ()) {
        collectionChildren.addDocument(data: [
            "name": child.name,
            "nickname": child.nickname,
            "colorHex": (child.colorHex ?? ""),
            "timeline": [Child.Timeline(type: .create, points: 0, description: "participante adicionado!", date: Date().description)].toArray()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func updateDatabase(child: Child, completion: @escaping(Bool) -> ()) {
        guard let documentId = child.id else {return}
        collectionChildren.document(documentId).updateData([
            "name": child.name,
            "nickname": child.nickname,
            "colorHex": (child.colorHex ?? "")
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document Updates")
                completion(true)
            }
        }
    }
}
