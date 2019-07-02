//
//  Cinema.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 7/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//
import Foundation
//import ObjectMapper

import Foundation
class Cinema{
    var id : Int?
    var name : String?
    var address : String?
    var telephone : String?
    //var functions: [Function]?
    var photoUrl : String? {
        didSet{
            guard let photoUrl = photoUrl else{
                self.photoUrl="https://static.thenounproject.com/png/340719-200.png"
                return
            }
        }
    }
    var bannerUrl : String? {
        didSet{
            guard let bannerUrl = bannerUrl else{
                self.bannerUrl="https://static.thenounproject.com/png/340719-200.png"
                return
            }
        }
    }

    
    /**
    required init?(map: Map) {
    }
}


extension Cinema: Mappable {
    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        telephone <- map["telephone"]
        functions <- map["functions"]
        photoUrl <- map["photoUrl"]
    }
 **/
}
