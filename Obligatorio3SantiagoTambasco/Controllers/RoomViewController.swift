//
//  RoomViewController.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 21/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//


import UIKit
import Firebase

class RoomViewController: UIViewController,ZSeatSelectorDelegate {

    @IBOutlet weak var nextButton: UIButton!


    var db: Firestore!
    var function = Function()
    var subtotal : Float?
    var room = Room()
    var rooms = SessionManager.rooms
    let seats2 = ZSeatSelector()
    
    override func viewWillAppear(_ animated: Bool) {
        
        db.collection("room").document("lpG3bNi5rykf78U0E27Q")
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
                let map2=self.room.map
                self.seats2.setMap(map2!)
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        // Do any additional setup after loading the view, typically from a nib.
     
        
        let map:String =    "AAAAA_DAAAA/" +
            "UAAAA_DAAAA/" +
            "UUUUU_DAAAA/" +
            "UAAAA_AAAAA/" +
        "AAAAA_AAAAA/";
        
        let seats = ZSeatSelector()
        seats.frame = CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 150)
        seats.setSeatSize(CGSize(width: 10, height: 10))
        seats.setAvailableImage(UIImage(named: "A")!,
                                andUnavailableImage:UIImage(named: "U")!,
                                andDisabledImage:   UIImage(named: "D")!,
                                andSelectedImage:   UIImage(named: "S")!)
        seats.layout_type = "Normal"
        seats.setMap(map)
        seats.seat_price = 10.0
        seats.selected_seat_limit = 3
        seats.seatSelectorDelegate = self
        //self.view.addSubview(seats)
        let map2=rooms.first?.map
        
        /*
         let map2:String =   "_DDDDDD_DDDDDD_DDDDDDDD_/" +
            "_AAAAAA_AAAAAA_DUUUAAAA_/" +
            "________________________/" +
            "_AAAAAUUAAAUAAAAUAAAAAAA/" +
            "_UAAUUUUUUUUUUUUUUUAAAAA/" +
            "_AAAAAAAAAAAUUUUUUUAAAAA/" +
            "_AAAAAAAAUAAAAUUUUAAAAAA/" +
        "_AAAAAUUUAUAUAUAUUUAAAAA/"
         */
        
        
        //let seats2 = ZSeatSelector()
        seats2.frame = CGRect(x: 0, y: 250, width: self.view.frame.size.width, height: 600)
        seats2.setSeatSize(CGSize(width: 30, height: 30))
        seats2.setAvailableImage(   UIImage(named: "A")!,
                                    andUnavailableImage:    UIImage(named: "U")!,
                                    andDisabledImage:       UIImage(named: "D")!,
                                    andSelectedImage:       UIImage(named: "S")!)
        seats2.layout_type = "Normal"
        seats2.setMap(map2!) //hacer el if let aca
        seats2.seat_price           = 5.0
        seats2.selected_seat_limit  = 5
        seats2.seatSelectorDelegate = self
        seats2.maximumZoomScale         = 5.0
        seats2.minimumZoomScale         = 0.05
        self.view.addSubview(seats2)
        
        self.view.bringSubview(toFront: nextButton)
       
    }
    

    
    func seatSelected(_ seat: ZSeat) {
        //print("Seat at row: \(seat.row) and column: \(seat.column)\n")
    }
    
    func getSelectedSeats(_ seats: NSMutableArray) {
        var total:Float = 0.0;
        for i in 0..<seats.count {
            let seat:ZSeat  = seats.object(at: i) as! ZSeat
            print("Seat at row: \(seat.row) and column: \(seat.column)\n")
            total += seat.price
        }
        subtotal = total
        print("----- Total -----\n")
        print("----- \(total) -----\n")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickNextButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PromotionViewSegue", sender: self)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="PromotionViewSegue"{
            if let controller = segue.destination as? PromotionsViewController{
                controller.subtotal=subtotal
            }
        }
    }

}
