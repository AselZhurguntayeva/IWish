//
//  ModelPersistence.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/29/22.
//

import Foundation

class ModelPersistence {
    
    static let shared = ModelPersistence() 
    
    // MARK: - Persistence
    // create a place to store data, save data, load data,
    
    func createPersistenceStore () -> URL { // URL - address in memory
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("WishList.json")
        return fileURL
    }
    
    func saveToPersistenceStore(wishLists: [WishList]) {
        do {
            let data = try JSONEncoder().encode(wishLists) // converting our song array to json data
            try data.write(to: createPersistenceStore())// decoding
        } catch {
            print("Error encoding.")
        }
    }
    func loadFromPersistenceStore() -> [WishList] {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            //                        decode as,           decode from
           let wishLists = try JSONDecoder().decode([WishList].self, from: data)
            return wishLists
        } catch {
            print("Error decoding.")
        }
        return []
    }
}
