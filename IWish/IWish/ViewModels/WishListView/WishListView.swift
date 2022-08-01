//
//  WishListView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI
import Firebase

struct WishListView: View {
    @ObservedObject var wishListViewModel = WishListViewModel()
    
    @State private var title: String = ""
    @State var showSheet: Bool = false
    @State var date: Date = Date()
    @State private var showingPopover = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment (\.presentationMode) var presentationMode
    
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
                        .fullScreenCover(isPresented: $showSheet, content: { CreateWishList(wishListViewModel: wishListViewModel)
                        })
                    }
                }
                Spacer()
                ZStack(alignment: .trailing) {
                    VStack{
                    List {
                        ForEach(wishListViewModel.wishLists, id: \.self) { (item: WishList) in NavigationLink {
                            ItemView(wishList: item, wishListViewModel: wishListViewModel)
                        } label: {
                            VStack {
                                Text(item.title)
                                    .font(.headline)
                                    .padding(.bottom, 5)
                               
                                Text(wishListViewModel.getDateOfWishList(date: item.date))
                                    .font(.subheadline)
                               
                                Image(systemName: "gift")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120, alignment: .trailing)
                                    .padding()
                                Text("Total: \(item.items.count) wishes")
                                    .font(.subheadline)
                                    .padding(.leading)
                                
                            }
                            .padding(.leading)
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
                        .padding(.leading, 50)
                        }
                       
                        .onDelete(perform: wishListViewModel.deleteWishList(at:))
            }
                    }
        }
            }
//            .navigationBarItems(trailing:
//                Button(action: {
////                isShowingShareActivity.toggle()
//            }, label: {
////                Image(systemName: "square.and.arrow.up")
//            })
//            )
            .navigationBarItems(leading:
        Button(action: {
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                 }, label: {
            Text("Log out")
                .foregroundColor(.black)
        })
        )
        }.navigationBarHidden(true)
    }
}
    
struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WishListView()
        }
    }
}


