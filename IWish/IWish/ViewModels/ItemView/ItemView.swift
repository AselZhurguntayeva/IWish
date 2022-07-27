//
//  ItemView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI

struct ItemView: View {
    
    @State private var itemName: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
    @State private var image: String = ""
    @State var showSheet: Bool = false
    @State private var isLiked = false
//    @State private var isShowingShareActivity = false
    @State private var showShareSheet = false
    
    @State var items: [Any] = []
   
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var itemViewModel = ItemViewModel()
    
    var wishList: WishList
    
    var wishListViewModel: WishListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                        TextField("Item Name", text: $itemName)
                            .padding(10)
                            .overlay(Rectangle()
                            .frame( height:3).padding(.top, 45))
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
                .navigationTitle(wishList.title)
                .navigationBarTitleDisplayMode(.inline)
               
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        })
                        .fullScreenCover(isPresented: $showSheet, content: { ItemDrawingView( itemViewModel: itemViewModel)
                        })
                    }
                }.padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                
                                items.append(itemName)
                                items.append(quantity)
                                items.append(price)
//                                self.showShareSheet = true
                                showShareSheet.toggle()
//                                isShowingShareActivity.toggle()
                            }, label: {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.black)
                            })
//                            .sheet(isPresented: $isShowingShareActivity, content: {
//                                    let items: [Any] = []
//                ActivityController(activityItems: items)
//                            })
                            .sheet(isPresented: $showShareSheet, content: {
                                
                                ShareSheet(items: ["Here is my \(wishList.title) wishlist"])
                            })
                            
                        }
                    }
                
                List {
                    ForEach(wishList.items)
                    { item in
                        cellBody( item: item, itemViewModel: itemViewModel)
//                        Button {
//                            itemViewModel.toggleIsLiked(for: item)
////                            print(item.isLiked)
////                            print (item.itemName)
//                        } label: {
//                            Image(systemName: item.isLiked ? "heart" : "heart.fill")
//                        }
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
                            itemViewModel.createItem(itemName: itemName, quantity: quantity, price: price, wishList: wishList, wishListViewModel: wishListViewModel)
                            itemName = ""
                            quantity = ""
                            price = ""
                            
                        } label: {
                            ZStack {
//                                Rectangle().fill(.ultraThinMaterial)
//                                    .cornerRadius(12)
                                Text("Save")
                                    .foregroundColor(.primary)
                                
                            }
                        }.frame(width: UIScreen.main.bounds.width - 80, height: 55)
                    }
                }
            }
        }
        
    }
//    func prepareForCreateItem(itemName: String?, quantity: String?, price: String?) {
//        guard let itemName = itemName, !itemName.isEmpty,
//        let quantity = quantity, !quantity.isEmpty,
//        let price = price, !price.isEmpty
//        else { return }
//        let item = Item(itemName: itemName, quantity: quantity, price: price)
//        itemViewModel.createItem(itemName: itemName, quantity: quantity, price: price, wishList: wishList, wishListViewModel: wishListViewModel)
//    }
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
        ItemView(wishList:
            WishList(title: "Christmas",
               items: [
                Item(itemName: "Dayson Hair Dryer", quantity: "1", price: "200")
               ]), wishListViewModel: WishListViewModel())
    }
}

struct cellBody: View {

  var item: Item
    
    @ObservedObject var itemViewModel: ItemViewModel
    
  var body: some View {
    HStack {
        Color.clear
        .frame(width: 20, height: 20, alignment: .leading)
        .clipShape(Rectangle())
        .cornerRadius(4)
        .overlay(
          Image(systemName: "app.gift")
            .resizable()
            .imageScale(.large)
            .foregroundColor(.black)
            
        )
        .imageScale(.large)
        .padding(.trailing)
      VStack(alignment: .leading) {
        Text(item.itemName)
          .foregroundColor(.primary)
          .font(.headline)
    }
      Spacer()
        Text(item.quantity)
          .foregroundColor(.primary)
          .font(.subheadline)
          .frame(width: 50, alignment: .center)
          
        Text(item.price ?? "none")// need to unwrapp it safely
            .foregroundColor(.primary)
            .font(.subheadline)
            .frame(width: 50, alignment: .center)
        
        .imageScale(.large)
        .foregroundColor(.primary)
        .frame(width: 30, alignment: .center)
//        .padding()
    }
    .padding()
    .cornerRadius(8)
//    .background(.gray)
  }
}
