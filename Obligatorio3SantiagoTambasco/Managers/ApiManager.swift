//
//  ApiManager.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 26/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
import Firebase

class ApiManager {
    var db: Firestore!
    static let shared = ApiManager()
    var room = Room()
    var rooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func getRooms(){
        self.db.collection("room").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let id = document.get("id") as! Int
                    let map = document.get("map") as! String
                    //print(id, title, duration, genre, photoUrl, director, releaseDate, ageRating)
                    self.room.id=id
                    self.room.map=map
                    self.rooms.append(self.room)
                    self.room = Room()
                    
                }
                SessionManager.rooms = self.rooms
            }
        }
    }
    
    
}

