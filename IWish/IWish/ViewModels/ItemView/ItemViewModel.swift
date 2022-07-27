//
//  ItemViewModel.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation

class ItemViewModel:ObservableObject {
    
   @Published var items: [Item] = []
    
//    func createItem(item: Item, wishList: WishList, wishListViewModel: WishListViewModel) {
//        guard let index = wishListViewModel.wishLists.firstIndex(of: wishList) else { return }
//        wishListViewModel.wishLists[index].items.append(item)
//    }
//
    func createItem(itemName: String?, quantity: String?, price: String?, wishList: WishList, wishListViewModel: WishListViewModel) {
        guard let itemName = itemName, !itemName.isEmpty,
              let quantity = quantity,!quantity.isEmpty,
              let price = price
        else {
            return
        }
        let item = Item(itemName: itemName, quantity: quantity, price: price)
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
//    func toggleIsLiked(for item: Item) {
//       guard let index = items.firstIndex(of: item) else { return }
////        let item = items[index]
//        items[index].isLiked.toggle()
//        
//    }
    
    // MARK: - Persistence
    // create a place to store data, save data, load data,
    
    func createPersistenceStore () -> URL { // URL - address in memory
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Item.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(items) // converting our song array to json data
            try data.write(to: createPersistenceStore())// decoding
        } catch {
            print("Error encoding.")
        }
    }
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            //                        decode as,           decode from
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print("Error decoding.")
        }
    }
//    
}
