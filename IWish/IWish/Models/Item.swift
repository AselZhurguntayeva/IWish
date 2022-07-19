//
//  Item.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation
import UIKit

class Item: Identifiable, Equatable, ObservableObject {
   
    var itemName: String
    var quantity: String
    var price: String
    var isLiked: Bool 
    var id: String = UUID().uuidString
    var image: String?
    
    init(itemName: String, quantity: String, price: String, isLiked: Bool = false, id: String = UUID().uuidString, image: String?) {
        self.itemName = itemName
        self.quantity = quantity
        self.price = price
        self.isLiked = isLiked
        self.id = id
        self.image = image
    }
}
    extension Item {
       static func  == (lhs: Item, rhs: Item) -> Bool {
            lhs.id == rhs.id
        
    }
}
