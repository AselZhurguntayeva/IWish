//
//  ItemView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI
import PhotosUI

struct ItemView: View {
    
    @State private var itemName: String = ""
    @State private var price: String = ""
    @State private var quantity: String = ""
//    @State private var image: String = ""
    @State var showSheet: Bool = false
    @State private var isLiked = false
//    @State private var isShowingShareActivity = false
    @State private var showShareSheet = false
    @State private var isShowingPhotoLibrary = false
    @State var items: [Any] = []
    @State var image: UIImage?
    @State var displayItems: [Item] = []
    @State var triggerUpdate: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: ImageStorage
   
    var wishList: WishList
    
//    @State var itemImage = UIImage()
   
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
//                    Image(systemName: "photo.circle")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                    Button{
//
//                    }label:{
//                    Text("Photos")
//                    }
                }
//                .navigationTitle(wishList.title)
//                .font(.custom("Kanit-SemiBold", size: 20))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal){
                        Text("\(wishList.title)")
                            .font(.custom("Kanit-Regular", size: 20))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
                            Image(systemName: "hand.draw")
                                .foregroundColor(.blue)
                        })
                        .fullScreenCover(isPresented: $showSheet, content: { ItemDrawingView( itemViewModel: itemViewModel)
                        })
                    }
                }.padding()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem{
                        Button(action: {
                            isShowingPhotoLibrary.toggle()
                        }, label: {
                            Image(systemName: "camera")
                                .foregroundColor(.blue)
                        })
                        .fullScreenCover(isPresented: $isShowingPhotoLibrary, onDismiss: nil) {
                            ImagePicker(image: $image)
//                            ImagePicker(selectedItem: itemName, selectedImage: <#T##UIImage#>,sourceType: vm.sourceType == .photoLibrary)
                        }
                    }
                }
                    
                
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                items.append(itemName)
                                items.append(quantity)
                                items.append(price)

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
                                
                                ShareSheet(items: ["\(wishList.title): \(wishList.self.items)"])
                            })
                        }
                    }
                
                List {
                    ForEach(displayItems)
                    { item in
                        cellBody( item: item, itemViewModel: itemViewModel)
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
                            itemViewModel.createItem(itemName: itemName, quantity: quantity, price: price, image: image, wishList: wishList, wishListViewModel: wishListViewModel)
                            itemName = ""
                            quantity = ""
                            price = ""
                            image = image
                            self.triggerUpdate.toggle()
                        } label: {
                            ZStack {
//                                Rectangle().fill(.ultraThinMaterial)
//                                    .cornerRadius(12)
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
//            .sheet(isPresented: $isShowingPhotoPicker, content: {
//                PhotoPicker(itemImage: $itemImage)
//            })
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
  @State private var isShowingPhotoPicker = false
 @State var image = UIImage()
    
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
        Image(uiImage: image)
            .resizable()
            .frame(width: 50, height: 50)
            .scaledToFill()
//            .onTapGesture {
//                isShowingPhotoPicker = true
//            }
    }
    .padding()
    .cornerRadius(8)
//    .background(.gray)
  }
}
