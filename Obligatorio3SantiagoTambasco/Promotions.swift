//
//  Movie.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 7/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

//import ObjectMapper
import Foundation
class Promotions{
    var id : Int?
    var name : String?
    var price : Double?
    var quantity : Int?
    var photoUrl : String? {
        didSet{
            guard let photoUrl = photoUrl else{
                self.photoUrl="https://static.thenounproject.com/png/340719-200.png"
                return
            }
        }
    }
    
/**
    
    required init?(map: Map) {
    }
}


extension Promotions: Mappable {
    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        price <- map["price"]
        quantity <- map["quantity"]
        photoUrl <- map["photoUrl"]
    }
 **/
}

