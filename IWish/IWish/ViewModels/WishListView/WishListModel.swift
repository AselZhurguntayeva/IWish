//
//  WishListModel.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import Foundation

class WishListViewModel: ObservableObject {
    
    @Published var wishLists:  [WishList] = []
//    @Published var date: Date = Date()
    // CRUD
//    func createWishList(_ wishList: WishList) {
//        wishLists.append(wishList)
//    }
    
    func createWishList(title: String, date: Date?) {
//        guard let title = title, !title.isEmpty,
//              let date = date, !date.isEmpty else { return }
//             guard let date = date,
//             let title = title, !title.isEmpty else  { return }
        guard !title.isEmpty else { return }
        var wishList = WishList(title: title)
        if let date = date {
            wishList.date = date
        }
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
    
    func getDateOfWishList(date: Date) -> String {
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Persistence
    // create a place to store data, save data, load data,
    
    func createPersistenceStore () -> URL { // URL - address in memory
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("WishList.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(wishLists) // converting our song array to json data
            try data.write(to: createPersistenceStore())// decoding
        } catch {
            print("Error encoding.")
        }
    }
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            //                        decode as,           decode from
            wishLists = try JSONDecoder().decode([WishList].self, from: data)
        } catch {
            print("Error decoding.")
        }
    }
}

