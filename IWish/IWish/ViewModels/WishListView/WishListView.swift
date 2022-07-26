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
    @State var date: Date = Date()
    
//    @State private var isShowingShareActivity = false
    
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
                                .foregroundColor(.primary)
                        })
                        .fullScreenCover(isPresented: $showSheet, content: { CreateWishList( date: date, wishListViewModel: wishListViewModel)
                        })
                    }
                }
                Spacer()
                ZStack(alignment: .trailing) {
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
                                    .frame(width: 120, height: 120, alignment: .trailing)
                                    .background(.red)
                                Text("Total:\(item.items.count) items")
                                    .font(.subheadline)
                                Text("")
                            }
                            .padding()
    //                        HStack {
    //                            Button {
    //                                isShowingShareActivity.toggle()
    //                            } label: {
    //                                Image(systemName: "square.and.arrow.up")
    //                            }
    //                        }
                        }
    //                    .navigationBarItems(trailing:
    //                        Button(action: {
    //                        isShowingShareActivity.toggle()
    //                    }, label: {
    //                        Image(systemName: "square.and.arrow.up")
    //                    })
    //                    )
                            
                    }
                        .onDelete(perform: wishListViewModel.deleteWishList(at:))
                    }
                }
            }
//            .navigationBarItems(trailing:
//                Button(action: {
//                isShowingShareActivity.toggle()
//            }, label: {
//                Image(systemName: "square.and.arrow.up")
//            })
//            )
        }.navigationBarHidden(true)
    }
//    func setupViews() {
//        wishListViewModel.createWishList(title: title, date: date)
//        
//    }
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


