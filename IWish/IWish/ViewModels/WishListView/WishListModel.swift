//
//  WishListModel.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation

class WishListViewModel: ObservableObject {
    
    @Published var wishLists:  [WishList] = []
    // CRUD
    func createWishList(_ wishList: WishList) {
        wishLists.append(wishList)
    }
    
    func updateWishList(_ wishList: WishList) {
        guard let index = wishLists.firstIndex(where: { $0.id == wishList.id }) else
        {return}
        wishLists[index] = wishList
    }
    
    func deleteWishList(at indexSet: IndexSet) {
        wishLists.remove(atOffsets: indexSet)
    }
}
