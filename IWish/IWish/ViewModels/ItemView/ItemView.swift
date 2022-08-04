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
    
    @ObservedObject var itemViewModel = ItemViewModel()
   
    var wishList: WishList
    @State var displayItems: [Item] = []
    @State var triggerUpdate: Bool = false
    
    @ObservedObject var wishListViewModel: WishListViewModel
    
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
                                .foregroundColor(.blue)
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
                                    .foregroundColor(.blue)
                            })
//                            .sheet(isPresented: $isShowingShareActivity, content: {
//                                    let items: [Any] = []
//                ActivityController(activityItems: items)
//                            })
                            .sheet(isPresented: $showShareSheet, content: {
                                
                                ShareSheet(items: ["I am having a \(wishList.title) soon!"])
                            })
                        }
                    }
                
                List {
                    ForEach(displayItems)
                    { item in
                        cellBody( item: item, itemViewModel: itemViewModel)
//
                    }
                    .onDelete { indexSet in
                        itemViewModel.deleteItem(wishList: wishList, wishListViewModel: wishListViewModel, at: indexSet)
                    }
                }.background(.blue)
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
//                                Rectangle().fill(.ultraThinMaterial)
//                                    .cornerRadius(12)
                                Text("Save")
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
