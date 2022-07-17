//
//  ItemViewModel.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation

class ItemViewModel:ObservableObject {
    
   @Published var items: [Item] = []
    
    func createItem(item: Item, wishList: WishList, wishListViewModel: WishListViewModel) {
        guard let index = wishListViewModel.wishLists.firstIndex(of: wishList) else { return }
        wishListViewModel.wishLists[index].items.append(item)
    }
//    func updateItem(item: Item, wishList: WishList, wishListViewModel: WishListViewModel) {
//        guard let index = items.firstIndex(of: item) else {return}
//
//    }
    
    func deleteItem(wishList: WishList, wishListViewModel:WishListViewModel, at indexSet:IndexSet) {
        guard let index = wishListViewModel.wishLists.firstIndex(of: wishList) else { return }
        wishListViewModel.wishLists[index].items.remove(atOffsets: indexSet)
    }
    func toggleIsDone(for item: Item) {
       guard let index = items.firstIndex(of: item) else { return }
//        let item = items[index]
        items[index].isLiked.toggle()
        
    }
    
}
