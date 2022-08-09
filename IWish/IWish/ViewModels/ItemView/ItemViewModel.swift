//
//  ItemViewModel.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation
import UIKit

class ItemViewModel:ObservableObject {
    
   @Published var items: [Item] = []
    
    
    func createItem(itemName: String?, quantity: String?, price: String?, image: UIImage?, wishList: WishList, wishListViewModel: WishListViewModel) {
        guard let itemName = itemName, !itemName.isEmpty,
              let quantity = quantity,!quantity.isEmpty,
              let image = image,
              let price = price
        else {
            return
        }
        let item = Item(itemName: itemName, quantity: quantity, price: price)
        guard let index = wishListViewModel.wishLists.firstIndex(of: wishList) else { return }
            wishListViewModel.wishLists[index].items.append(item)
        ModelPersistence.shared.saveToPersistenceStore(wishLists: wishListViewModel.wishLists)
    }
    
    
//    func updateItem(item: Item, wishList: WishList, wishListViewModel: WishListViewModel) {
//        guard let index = items.firstIndex(of: item) else {return}
//
//    }
    
    func deleteItem(wishList: WishList, wishListViewModel:WishListViewModel, at indexSet:IndexSet) {
        guard let index = wishListViewModel.wishLists.firstIndex(of: wishList) else { return }
        wishListViewModel.wishLists[index].items.remove(atOffsets: indexSet)
        ModelPersistence.shared.saveToPersistenceStore(wishLists: wishListViewModel.wishLists)
    }
}
