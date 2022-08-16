//
//  ItemView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI
import UIKit


struct ItemView: View {
    
    @State private var itemName: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
    @State var showSheet: Bool = false
    @State private var showShareSheet = false
    @State private var isShowingWebStore = false
    @State var items: [Any] = []
    @State var displayItems: [Item] = []
    @State var triggerUpdate: Bool = false
//    @State private var show : Bool = false
    
    @Environment(\.dismiss) private var dismiss
   
    var wishList: WishList
    
    @ObservedObject var itemViewModel = ItemViewModel()
    @ObservedObject var wishListViewModel: WishListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                        TextField("Item Name", text: $itemName)
                        .font(.custom("Kanit-Regular", size: 18))
                            .padding(10)
                            .overlay(Rectangle()
                            .frame( height:3).padding(.top, 45))
                        HStack {
                            TextField("Quantity", text: $quantity)
                                .font(.custom("Kanit-Regular", size: 18))
                                .padding(10)
                                .overlay(
                                    Rectangle().frame(height: 3)
                                    .padding(.top, 45))
                            TextField("Price", text: $price)
                                .font(.custom("Kanit-Regular", size: 18))
                                .padding(10)
                                .overlay(
                                Rectangle()
                                .frame(height: 3)
                            .padding(.top, 45))
                    }
                        .padding(.bottom, 5)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal){
                        Text("\(wishList.title)")
                            .font(.custom("Kanit-Regular", size: 20))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
                            Image(systemName: "hand.draw")
                                .foregroundColor(.blue)
                        })
                        .fullScreenCover(isPresented: $showSheet, content: { ItemDrawingView( itemViewModel: itemViewModel)
                        })
                    }
                }
                .padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            isShowingWebStore.toggle()
                        }, label: {
                            Image("explore")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 26, height: 26)
                        })
                        .popover(isPresented: $isShowingWebStore, content: {
                            WebStoreView()
                        })
                    }
                }  .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                items.append(itemName)
                                items.append(quantity)
                                items.append(price)

                                showShareSheet.toggle()
                            }, label: {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.blue)
                            })
                            .sheet(isPresented: $showShareSheet, content: {
                                
                                ShareSheet(items: ["\(wishList.title): \(wishList.self.items)"])
                            })
                        }
                    }
                List {
                    ForEach(displayItems)
                    { item in
                        cellBody( item: item, itemViewModel: itemViewModel)
                    }.onDelete { indexSet in
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
                            self.triggerUpdate.toggle()
                        } label: {
                            ZStack {
                                Text("Save")
                                    .font(.custom("Kanit-Light", size: 18))
                                    .foregroundColor(.blue)
                            }
                        }.frame(width: UIScreen.main.bounds.width - 80, height: 55)
                    }
                }
            }.onAppear {
                self.displayItems = wishList.items
            }
            .onChange(of: triggerUpdate) { update in
                if update {
                    self.triggerUpdate.toggle()
                    self.displayItems = (wishListViewModel.wishLists.first(where: { wishList in
                        wishList.id == self.wishList.id
                    }))?.items ?? []
                }
                   
            }
        }
        
    }
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

  @State var item: Item

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
            .foregroundColor(.primary)
            
        )
        .imageScale(.large)
        .padding(.trailing)
      VStack(alignment: .leading) {
        Text(item.itemName)
          .foregroundColor(.primary)
          .font(.custom("Kanit-Regular", size: 18))
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
        .padding()
    }
    .padding()
    .cornerRadius(8)
  }
}
