//
//  ItemView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI

struct ItemView: View {
    
//    @State private var title: String = ""
    @State private var itemName: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
    @State private var isLiked = false
    
    
    @State private var itemViewModel = ItemViewModel()
    
    @Binding var wishList: WishList
    
    var wishListViewModel: WishListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Item Name", text: $itemName)
                        .padding(10)
                        .overlay(Rectangle().frame( height: 3).padding(.top, 45))
                    HStack {
                        TextField("Quantity", text: $quantity)
                            .padding(10)
                            .overlay(
                                Rectangle().frame(height: 3)
                                    .padding(.top, 45))
                        TextField("Price", text: $price)
                            .padding(10)
                            .overlay(
                            Rectangle()
                            .frame(height: 3)
                            .padding(.top, 45))
                    }
                    .padding(-5)
                }
                .navigationTitle("Wish List Title")
                List {
                    ForEach(wishList.items)
                    { item in
                        cellBody( item: item, itemViewModel: itemViewModel)
                        Button(action: {
                            itemViewModel.toggleIsDone(for: item)
                            print(item.isLiked)
                            print (item.itemName)
                        }, label: {
                            Image(systemName: item.isLiked ? "heart" : "heart.fill")
                        })
                    }
                    .onDelete { indexSet in
                        itemViewModel.deleteItem(wishList: wishList, wishListViewModel: wishListViewModel, at: indexSet)
                    }
                }
                .listStyle(GroupedListStyle())
                .listRowBackground(Color.clear)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            itemViewModel.createItem(item: Item(itemName: itemName, quantity: quantity, price: price), wishList: wishList, wishListViewModel: wishListViewModel)
                            itemName = ""
                            quantity = ""
                            price = ""
                        } label: {
                            ZStack {
                                Rectangle().fill(.ultraThinMaterial)
                                    .cornerRadius(12)
                                Text("Save")
                                    .foregroundColor(.primary)
                            }
                        }.frame(width: UIScreen.main.bounds.width - 20, height: 55)
                    }
                }
            }
            
            
            
            
        }
        
    }
    func prepareForCreateItem(itemName: String?, quantity: String?, price: String?) {
        guard let itemName = itemName, !itemName.isEmpty,
        let quantity = quantity, !quantity.isEmpty,
        let price = price, !price.isEmpty
        else { return }
        let item = Item(itemName: itemName, quantity: quantity, price: price)
        itemViewModel.createItem(item: item, wishList: wishList, wishListViewModel: wishListViewModel)
    }
//    func prepareForUpdateItem() {
//        let itemName = itemName
//        let quantity = quantity
//        let price = price
//
//        guard !itemName.isEmpty, !quantity.isEmpty, !price.isEmpty else {
//            return
//        }
//        if let item = item {
//            itemViewModel.update
//        }
//    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(wishList: .constant(
            WishList(title: "Christmas",
               items: [
               Item(itemName: "Dayson Hair Dryer", quantity: "1", price: "$200")
               ])), wishListViewModel: WishListViewModel())
    }
}

struct cellBody: View {

  var item: Item
    
    @ObservedObject var itemViewModel: ItemViewModel
    
  var body: some View {
    HStack {
      Color.black
        .frame(width: 40, height: 40, alignment: .leading)
        .clipShape(Rectangle())
        .cornerRadius(4)
        .overlay(
          Image(systemName: "app.gift")
            .imageScale(.large)
            .foregroundColor(.white)
        )
        .imageScale(.large)
      VStack(alignment: .leading) {
        Text(item.itemName)
          .foregroundColor(.primary)
          .font(.headline)
        
      }
      Spacer()
        Text(item.quantity)
          .foregroundColor(.primary)
          .font(.subheadline)
          .background(.yellow)
          .frame(width: 50, alignment: .center)
          Text(item.price)
            .foregroundColor(.primary)
            .font(.subheadline)
            .frame(width: 50, alignment: .center)
//        Button(action: {
//            itemViewModel.toggleIsDone(for: item)
//            print(item.isLiked)
//        }, label: {
//            Image(systemName: item.isLiked ? "heart" : "heart.fill")
//        })
        
        .imageScale(.large)
        .foregroundColor(.primary)
        .frame(width: 30, alignment: .center)
//        .padding()
    }
    .padding()
    .cornerRadius(8)
  }
}
