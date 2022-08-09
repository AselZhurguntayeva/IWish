//
//  Item.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation
import SwiftUI

struct Item: Identifiable, Equatable, Hashable, Codable {
   
    var itemName: String
    var quantity: String
    var price: String?
    var id: String = UUID().uuidString
    var image: String?
    
//    init(itemName: String, quantity: String, price: String, id: String = UUID().uuidString) {
//        self.itemName = itemName
//        self.quantity = quantity
//        self.price = price
////        self.isLiked = isLiked
//        self.id = id
////        self.image = image
//    }
}
    extension Item {
       static func  == (lhs: Item, rhs: Item) -> Bool {
            lhs.id == rhs.id
        
    }
}

