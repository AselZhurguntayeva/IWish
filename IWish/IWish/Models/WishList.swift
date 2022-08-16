//
//  WishList.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation

struct WishList: Identifiable, Equatable, Hashable, Codable {
    
    var title: String
    var items: [Item] = []
    var id: String = UUID().uuidString
    var date: Date = Date()
    
    static func ==(lhs: WishList, rhs: WishList) -> Bool {
        lhs.id == rhs.id
    }
}
