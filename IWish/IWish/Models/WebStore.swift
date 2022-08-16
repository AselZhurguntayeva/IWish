//
//  WebStore.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 8/14/22.
//

import Foundation

struct StoresData: Identifiable, Hashable{
    var id = UUID()
    var storeURL: String
    var title: String
    var image: String
}
 var sData = [
    StoresData(storeURL: "https://www.walmart.com", title: "walmart", image: "walmart"),
    StoresData(storeURL: "https://www.zara.com", title: "zara", image: "zara"),
    StoresData(storeURL: "https://www.nike.com", title: "nike", image: "nike"),
    StoresData(storeURL: "https://www.sephora.com", title: "sephora", image: "sephora"),
    StoresData(storeURL: "https://www.rei.com", title: "rei", image: "rei"),
    StoresData(storeURL: "https://www.hm.com", title: "hm", image: "hm"),
    StoresData(storeURL: "https://shop.sportsbasement.com", title: "sportsbasement", image: "sportsbasement"),
    StoresData(storeURL: "https://gap.com", title: "gap", image: "gap"),
    StoresData(storeURL: "https://disney.com", title: "disney", image: "disney"),
    StoresData(storeURL: "https://nordstrom.com", title: "nordstrom", image: "nordstrom"),
    StoresData(storeURL: "https://asos.com", title: "asos", image: "asos")
 ]
