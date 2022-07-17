//
//  WishListView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI

struct WishListView: View {
    @ObservedObject var wishListViewModel = WishListViewModel()
    //@StateObject private var wishListViewModel = WishListViewModel()
    @State private var title: String = ""
    @State var showSheet: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    Text("My Wish Lists")
                        .font(.title)
                        .fontWeight(.semibold)
                    .background(.blue)
                }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showSheet.toggle()
//                                wishListViewModel.createWishList(WishList(title: title))
//                                title = ""
                            }, label: {
                                Image(systemName: "plus")
                            })
                            .fullScreenCover(isPresented: $showSheet, content: { CreateWishList( wishListViewModel: wishListViewModel)
                            })
                        }
                        
                    }
                    .onAppear {
                        setupViews()
                    }
                
                    Spacer()
                List {
                    ForEach($wishListViewModel.wishLists) { item in NavigationLink {
                        ItemView(wishList: item, wishListViewModel: wishListViewModel)
                    } label: {
                        VStack(alignment:.center) {
                            Text(item.title.wrappedValue)
                                .font(.headline)
                            Image(systemName: "gift")
                                .frame(width: 50, height: 50, alignment: .center)
                            Text("Wish List \(item.items.count) items")
                                .font(.subheadline)
                        }
                        .padding()
                    }
                    
                        
                    }
                    .onDelete(perform: wishListViewModel.deleteWishList(at:))
                }
            }.background(.yellow)
                
        }
    }
    func setupViews() {
        wishListViewModel.createWishList(WishList(title: title))
        
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
    }
}


