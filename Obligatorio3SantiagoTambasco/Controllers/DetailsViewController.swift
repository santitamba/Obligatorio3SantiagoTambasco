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
    
    var detailItems  = [Item]()
    var totalPrice: Float = 0
    var db: Firestore!
    var asientos = [ZSeat]()
    var subtotal : Float?
    var final = ""
    
    var originRoom = SessionManager.room
    var room = Room()
    var selected = ""
    var NewRoomMap = ""
    //var mapUpdate = SessionManager.selected_seats//"_AAAAAA_AAAAAA_AAAAAAAA_/_AAAAAA_AAAAAA_AUUUAAAA_/________________________/_AAAAAUUAAAUAAAAUAAAAAAA/_UAAUUUUUUUUUUUUUUUAAAAA/_AAAAAAAAAAAUUUUUUUAAAAA/_AAAAAAAAUAAAAUUUUAAAAAA/_AAAAAUUUAUAUAUAUUUAAAUU/"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        finshPurchaseButton.layer.cornerRadius = 20
        finshPurchaseButton.clipsToBounds = true
        /*
         finshPurchaseButton.layer.borderWidth = 1
         finshPurchaseButton.layer.borderColor = UIColor.purple.cgColor
         
         finshPurchaseButton.backgroundColor = UIColor.white
         finshPurchaseButton.tintColor = UIColor.purple
         */
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        //print(asientos)
        final = SessionManager.room.map!//(SessionManager.rooms.first?.map)!
        detailItems=SessionManager.detailItems!
        selected=final
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for asiento in asientos{
            calculateMatrix(asiento: asiento)
            calculateMatrixSelected(asiento: asiento)
        }
        print("este si \(final)")
        detailsViewController.reloadData()
        totalAmount()
        
        //Para validar que nadie compre mi asiento
        var documentId=SessionManager.room.docId!
        db.collection("room").document(documentId)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                print("Current data: \(document.data())")
                
                let id = document.get("id") as! Int
                let map = document.get("map") as! String
                self.room.map=map
                self.room.id=id
                
               
                var originMatRoom = Array(self.selected)
                var newMatRoom = Array(self.room.map!)
                var cont = 0
                for (e1, e2) in zip(originMatRoom, newMatRoom) {
                    print("\(e1) - \(e2)")
                    if e1=="S" && e2=="U"{
                        self.asientos = [ZSeat]()
                        var title = "Error"
                        var message = "Acaban de comprar tu asiento"
                        var buttonTitle = "Aceptar"
                        let alert = UIAlertController(title: title, message: message,preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: buttonTitle,style: .default, handler: self.indexAlert1))
                        self.present(alert, animated: true)
                    }
                    else if  e1=="A" && e2=="U"{
                        var NewRoomMap = self.room.map
                        for asiento in self.asientos{
                            self.calculateMat(asiento: asiento, map: NewRoomMap!)
                        }
                    }
                }
                //tengo que recorrer el original y todos los que ahora son nuevos U validarlos contra mis asientos si alguno coincide mandar un cartel de aviso y volver a la de seleccionar asientos
        }
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indexAlert1(alert: UIAlertAction!){
        SessionManager.deleteAllData()
        //self.navigationController?.popViewController(animated: true)
        
        self.navigationController!.popToViewController(navigationController!.viewControllers[2], animated: false)
        
    }

    
    func calculateMat(asiento: ZSeat, map: String){
        var val = 0
        if asiento.row == 1{
            val = (asiento.column-1)
        }
        else{
            val = (((asiento.row-1)*24)+(asiento.column-1))+(asiento.row-1)
        }
        StringToMat(value: val,map: map )
    }
    
    func StringToMat(value: Int, map: String){
        var characters = Array(map)
        characters[value] = "U"
        //print(characters.count)
        matrixToStringSel(matrix: characters)
    }
    
    
    func matrixToStringSel(matrix: [String.Element]) {
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
    
    func calculateMatrixSelected(asiento: ZSeat){
        var val = 0
        if asiento.row == 1{
            val = (asiento.column-1)
        }
        else{
            val = (((asiento.row-1)*24)+(asiento.column-1))+(asiento.row-1)
        }
        StringToMatrixSelected(value: val)
    }
    
    func StringToMatrixSelected(value: Int){
        var characters = Array(selected)
        characters[value] = "S"
        //print(characters.count)
        matrixToStringSelected(matrix: characters)
    }
    
    
    func matrixToStringSelected(matrix: [String.Element]) {
        //var stringRepresentation = ""
        var mapTemp = ""
        for elem in matrix{
            //stringRepresentation = elem.joined(separator:"")
            //stringRepresentation = stringRepresentation + "/"
            mapTemp = mapTemp + elem.description
        }
        selected = mapTemp
        print ("matriz de selected \(selected) -----\n")
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
        totalPrice = subtotal!
        var cartPromotion=SessionManager.cartPromotion
        //var cartPromotion=SessionManager.promotions
        if let cartPromotion = cartPromotion{
            for elem in cartPromotion{
                var unitPrice = Float(elem.price!)
                totalPrice = totalPrice+(Float(elem.quantity!) * unitPrice)
            }
            totalLabel.text = "Total $" + String(totalPrice)
        }
        else{
            totalLabel.text = "Total $" + String(totalPrice)
        }
    }
    
    
    func updateMap(){
        let roomRef = db.collection("room").document(SessionManager.room.docId!)
        
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
        if detailItems.count==0{
            return 0
        }
        else{
            return detailItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDetails = tableView.dequeueReusableCell(withIdentifier: "cellDetails", for: indexPath) as! DetailsTableViewCell
        
        //cellDetails.detailItems=detailItems!
        var myItem = detailItems[indexPath.row]
        //for myItem in detailItems!{
        cellDetails.item = myItem
        //if myItem.quantity!>0{
        //cellDetails.configureCell()
        
        //}
        //}
        cellDetails.configureCell()
        return cellDetails

        /*
        cellDetails.detailItems = detailItems! //Si o si tiene que tener por lo menos una butaca si no no podes avanzar por eso tiene el !
        //let myItems = detailItems![indexPath.row]
        
        for myItems in detailItems!{
        cellDetails.item = detailItems!
        let item = myItems//myItems[indexPath.row]//
        
        //if let item = item{
            if item.quantity!>0{
                cellDetails.configureCell()
            }
        //}
           // return cellDetails
        }
        
        return cellDetails
        */
        
    }
    
}
