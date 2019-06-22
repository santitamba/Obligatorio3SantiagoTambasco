//
//  ViewControllerPromotions.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 12/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Firebase

class PromotionsViewController: UIViewController {
    
    @IBOutlet weak var promotionCollectionView: UICollectionView!
    var db: Firestore!
    var promotions = [Promotions]()
    let promotion = Promotions()

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
    
    var id : Int?
    var name : String?
    var price : Double?
    var quantity : Int?
    var photoUrl : String?
    var subtotal : Float?
    
    func getPromotions(){
        self.db.collection("promotions").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let id = document.get("id") as! Int
                    let name = document.get("name") as! String
                    let price = document.get("price") as! Double
                    let quantity = document.get("quantity") as! Int
                    let photoUrl = document.get("photoUrl") as! String

                    self.promotion.id=id
                    self.promotion.name=name
                    self.promotion.price=price
                    self.promotion.quantity=quantity
                    self.promotion.photoUrl=photoUrl
                    self.promotions.append(self.promotion)
                }
                SessionManager.promotions = self.promotions
            }
        }
        
    }
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
