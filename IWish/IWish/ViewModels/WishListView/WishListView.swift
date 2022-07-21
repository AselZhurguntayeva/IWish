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
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .fullScreenCover(isPresented: $showSheet, content: { CreateWishList( wishListViewModel: wishListViewModel)
                        })
                    }
                }
                Spacer()
                List {
                    ForEach($wishListViewModel.wishLists) { item in NavigationLink {
                        ItemView(wishList: item, wishListViewModel: wishListViewModel)
                    } label: {
                        VStack(alignment:.leading) {
                            Text(item.title.wrappedValue)
                                .font(.headline)
                            Image(systemName: "gift")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .trailing)
                                .background(.red)
                            Text("Total:\(item.items.count) items")
                                .font(.subheadline)
                        }
                        .padding()
                    }
                }
                    .onDelete(perform: wishListViewModel.deleteWishList(at:))
                }
            }
            
        }.navigationBarHidden(true)
    }
    func setupViews() {
        wishListViewModel.createWishList(WishList(title: title))
        
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WishListView()
            WishListView()
                .previewInterfaceOrientation(.landscapeLeft)
            WishListView()
        }
    }
}


