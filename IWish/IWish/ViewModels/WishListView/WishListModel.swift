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
//    func createWishList(_ wishList: WishList) {
//        wishLists.append(wishList)
//    }
    
    func createWishList(title: String?, date: Date?, wishList: WishList, wishListViewModel: WishListViewModel) {
//        guard let title = title, !title.isEmpty,
//              let date = date, !date.isEmpty else { return }
             guard let date = date,
             let title = title, !title.isEmpty else  { return }
        let wishList = WishList(title: title, date: date)
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
