//
//  ViewController.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 7/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseDatabase

class BillboardViewController: UIViewController{

    var db: Firestore!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        getPromotions()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPromotions(){
        db.collection("promotions").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }

    }
}

extension BillboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesCollectionView {
            return 1
        } else if collectionView == cinemasCollectionView{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

