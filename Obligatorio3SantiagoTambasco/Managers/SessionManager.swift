//
//  File.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 21/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import Foundation
class SessionManager {
    
    static let shared = SessionManager()
    static var movies = [Movie]()
    static var functions = [Function]()
    static var cinemas = [Cinema]()
    static var promotions: [Promotions]?
    static var rooms = [Room]()
    static var cartPromotion: [Promotions]?
    static var detailItems: [Item]?
    static var tickets: [Item]?
    static var newMap: String?
    static var selected_seats = NSMutableArray()
    

    
    static func deleteAllData(){
        self.cartPromotion = [Promotions]()
        self.detailItems = [Item]()
        self.tickets = [Item]()
        self.newMap = ""
        self.rooms = [Room]()
        self.selected_seats = NSMutableArray()
    }
    
}
