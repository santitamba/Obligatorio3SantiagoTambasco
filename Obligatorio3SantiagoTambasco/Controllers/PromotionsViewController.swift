//
//  ViewControllerPromotions.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 12/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Firebase

protocol UpdatePromotionDelegate {
    func add(item: Promotions)
    func remove(item: Promotions)
    func totalAmount()
}

class PromotionsViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var promotionCollectionView: UICollectionView!
    var db: Firestore!
    var promotions = [Promotions]()
    var promotion = Promotions()
    var id : Int?
    var name : String?
    var price : Double?
    var quantity : Int?
    var photoUrl : String?
    var subtotal : Float?
    var totalPrice: Float = 0
    var item = Item()
    var items = [Item]()
    var sessionManager = SessionManager.shared
    var elements = SessionManager.promotions?.filter({$0.quantity! >= 0 })
    var asientos = [ZSeat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 20
        nextButton.clipsToBounds = true
        /*
         nextButton.layer.borderWidth = 1
         nextButton.layer.borderColor = UIColor.purple.cgColor
         
         nextButton.backgroundColor = UIColor.white
         nextButton.tintColor = UIColor.purple
         */
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        SessionManager.cartPromotion = [Promotions]()
        getPromotions()
        promotionCollectionView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        promotionCollectionView.reloadData()
        SessionManager.detailItems=SessionManager.tickets
        totalAmount()
        
    }
    


    
    
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
                    self.promotion = Promotions()
                    self.promotionCollectionView.reloadData()
                }
                SessionManager.promotions = self.promotions
            }
        }
        
    }
    

    @IBAction func nextButton(_ sender: Any) {

        self.performSegue(withIdentifier: "DetailsViewSegue", sender: self)
    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier=="DetailsViewSegue"{
        if let controller = segue.destination as? DetailsViewController{
            var cartPromotion=SessionManager.cartPromotion
            if let cartPromotion = cartPromotion{
                for elem in cartPromotion{
                    item.description=elem.name
                    item.price=Float(elem.price!)
                    item.quantity=elem.quantity
                    items.append(item)
                }
                controller.asientos = asientos
                controller.subtotal = subtotal
                SessionManager.detailItems?.append(items)
            }

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

extension PromotionsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //print(movies.count)
            return promotions.count

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //movieForSegue = movies[indexPath.row]
            //self.performSegue(withIdentifier: "FunctionViewSegue", sender: self)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cellPromotion=collectionView.dequeueReusableCell(withReuseIdentifier: "cellPromotion", for: indexPath) as? PromotionCollectionViewCell else { return UICollectionViewCell()}
            cellPromotion.promotion = promotions[indexPath.row]
            cellPromotion.promotions = promotions
            cellPromotion.delegate = self
            cellPromotion.configure()
            
            return cellPromotion
        
    }
    
}


extension PromotionsViewController: UpdatePromotionDelegate {
    
    func add(item: Promotions) {
        
        var currentItems = SessionManager.cartPromotion ?? []
        
        if var current = currentItems.filter({$0.id == item.id}).first{
            current.quantity = (current.quantity ?? 0) + 1
            //item.quantity = (item.quantity ?? 0) + 1
        } else {
            let newItem = item
            currentItems.append(newItem)
            item.quantity = 1
        }
        SessionManager.cartPromotion = currentItems
        promotionCollectionView.reloadData()
    }
    
    func remove(item: Promotions) {
        var currentItems = SessionManager.cartPromotion ?? []
        //SessionManager.cartItems = SessionManager.cartItems?.filter {$0.productId != item.id}
        var current = currentItems.filter({$0.id == item.id}).first
        current?.quantity = (current?.quantity ?? 0) - 1
        if current?.quantity==0{
            SessionManager.cartPromotion = SessionManager.cartPromotion?.filter {$0.id != item.id}
        }
        //item.quantity = (item.quantity ?? 0) - 1
        
        promotionCollectionView.reloadData()
    }
    
    func totalAmount(){
        totalPrice = subtotal!
        var cartPromotion=SessionManager.cartPromotion
        //var cartPromotion=SessionManager.promotions
        if let cartPromotion = cartPromotion{
            for elem in cartPromotion{
                var unitPrice = Float(elem.price!)
                totalPrice = totalPrice+(Float(elem.quantity!) * unitPrice)
            }
            totalPriceLabel.text = "Subtotal $" + String(totalPrice)
        }
        else{
            totalPriceLabel.text = "Subtotal $" + String(totalPrice)
        }
    }
    
}
