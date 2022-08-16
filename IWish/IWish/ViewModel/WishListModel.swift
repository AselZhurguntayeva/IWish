//
//  WishListModel.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation

class WishListViewModel: ObservableObject {
    
    @Published var wishLists:  [WishList] = ModelPersistence.shared.loadFromPersistenceStore()

    
    func createWishList(title: String, date: Date?) {
        guard !title.isEmpty else { return }
        var wishList = WishList(title: title)
        if let date = date {
            wishList.date = date
        }
        wishLists.append(wishList)
        ModelPersistence.shared.saveToPersistenceStore(wishLists: wishLists)
          
    }
    
    
    func deleteWishList(at indexSet: IndexSet) {
        wishLists.remove(atOffsets: indexSet)
        ModelPersistence.shared.saveToPersistenceStore(wishLists: wishLists)
    }
    
    func getDateOfWishList(date: Date) -> String {
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }
        return dateFormatter.string(from: date)
        
    }
    
    
}

