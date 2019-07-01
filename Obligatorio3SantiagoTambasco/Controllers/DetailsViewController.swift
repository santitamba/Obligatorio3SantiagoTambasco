//
//  DetailsViewController.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 28/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {

    @IBOutlet weak var finshPurchaseButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var detailsViewController: UITableView!
    
    var detailItems = SessionManager.detailItems
    var totalPrice: Float = 0
    var db: Firestore!
    var asientos = [ZSeat]()
    var final = ""
    //var mapUpdate = SessionManager.selected_seats//"_AAAAAA_AAAAAA_AAAAAAAA_/_AAAAAA_AAAAAA_AUUUAAAA_/________________________/_AAAAAUUAAAUAAAAUAAAAAAA/_UAAUUUUUUUUUUUUUUUAAAAA/_AAAAAAAAAAAUUUUUUUAAAAA/_AAAAAAAAUAAAAUUUUAAAAAA/_AAAAAUUUAUAUAUAUUUAAAUU/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        //print(asientos)
        final = (SessionManager.rooms.first?.map)!

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for asiento in asientos{
            calculateMatrix(asiento: asiento)
        }
        print("este si \(final)")
        detailsViewController.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateMatrix(asiento: ZSeat){
        var val = 0
        if asiento.row == 1{
            val = (asiento.column-1)
        }
        else{
            val = (((asiento.row-1)*24)+(asiento.column-1))+(asiento.row-1)
        }
        StringToMatrix(value: val)
    }
    
    func StringToMatrix(value: Int){
        var characters = Array(final)
        characters[value] = "U"
        //print(characters.count)
        matrixToString(matrix: characters)
    }
    
    
    func matrixToString(matrix: [String.Element]) {
        //var stringRepresentation = ""
        var mapTemp = ""
        for elem in matrix{
            //stringRepresentation = elem.joined(separator:"")
            //stringRepresentation = stringRepresentation + "/"
            mapTemp = mapTemp + elem.description
        }
        final = mapTemp
        //print ("acaa \(final) -----\n")
    }
    
    func totalAmount(){
        var detailItems = SessionManager.detailItems
        //var cartPromotion=SessionManager.promotions
        if let detailItems = detailItems{
            for item in detailItems{
                for elem in item{
                    var unitPrice = Float(elem.price!)
                    totalPrice = totalPrice+(Float(elem.quantity!) * unitPrice)
                }
            }
            totalLabel.text = "Subtotal $" + String(totalPrice)
        }
        else{
            totalLabel.text = "Subtotal $" + String(totalPrice)
        }
    }
    
    func updateMap(){
        let roomRef = db.collection("room").document("lpG3bNi5rykf78U0E27Q")
        
        // Set the "capital" field of the city 'DC'
        roomRef.updateData([
            "map": final
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }

    }
    
    func indexAlert(alert: UIAlertAction!){
        SessionManager.deleteAllData()
        //self.navigationController?.popViewController(animated: true)
        
        self.navigationController!.popToViewController(navigationController!.viewControllers[0], animated: false)

    }
    
    @IBAction func finishPurchaseButton(_ sender: Any) {
        updateMap()
        var title = "Exito"
        var message = "Compra realizada con exito"
        var buttonTitle = "Aceptar"
        let alert = UIAlertController(title: title, message: message,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle,style: .default, handler: self.indexAlert))
        self.present(alert, animated: true)
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

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //Row
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if detailItems?.count==0{
            return 0
        }
        else{
            return detailItems!.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDetails = tableView.dequeueReusableCell(withIdentifier: "cellDetails", for: indexPath) as! DetailsTableViewCell
        

        cellDetails.detailItems = detailItems! //Si o si tiene que tener por lo menos una butaca si no no podes avanzar por eso tiene el !
        //var myItems = detailItems![indexPath.row]
        
        for myItems in detailItems!{
        cellDetails.item = myItems
        var item = myItems.first
        
        if let item = item{
            if item.quantity!>0{
                cellDetails.configureCell()
            }
        }
            //return cellDetails
        }
        
        return cellDetails
        
    }
    
}
