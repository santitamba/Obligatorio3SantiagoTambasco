//
//  Movie.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 7/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

//import ObjectMapper
import Foundation
class Movie{
    var id : Int?
    var title : String?
    var duration : Int?
    var genre : String?
    var director : String?
    var releaseDate: String?
    var ageRating: String?
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
            guard let photoUrl = photoUrl else{
                self.photoUrl="https://static.thenounproject.com/png/340719-200.png"
                return
            }
        }
    }
    
    
    
  /**  required init?(map: Map) {
    }**/
}

/**
extension Movie: Mappable {
    func mapping(map: Map){
        id <- map["id"]
        title <- map["title"]
        duration <- map["duration"]
        genre <- map["genre"]
        director <- map["director"]
        releaseDate <- map["releaseDate"]
        ageRating <- map["ageRating"]
        photoUrl <- map["photoUrl"]
    }

} **/
