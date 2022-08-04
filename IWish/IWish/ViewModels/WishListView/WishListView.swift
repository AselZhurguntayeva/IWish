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
                        .font(.custom("Kanit-ExtraBold", size: 32))
                        .multilineTextAlignment(.center)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        })
                        .fullScreenCover(isPresented: $showSheet, content: { CreateWishList(wishListViewModel: wishListViewModel)
                        })
                    }
                }
                Spacer()
                ZStack {
                    VStack{
                    List {
                        ForEach(wishListViewModel.wishLists, id: \.self) { (item: WishList) in NavigationLink {
                            ItemView(wishList: item, wishListViewModel: wishListViewModel)
                        } label: {
                            HStack {
                                HStack{
                                Image(systemName: "gift")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .trailing)
                                    .padding(.trailing)
                            }
                                VStack{
                                Text(item.title)
                                        .font(.custom("Kanit Bold", size: 18))
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                               
                                Text(wishListViewModel.getDateOfWishList(date: item.date))
                                    .font(.subheadline)
                                    .padding(.bottom, 5)
                                Text("Total: \(item.items.count) wishes")
                                        .font(.custom("Kanit-Light", size: 16))
//
                                }
                                Spacer()
                            }
//                            .padding()
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
                        .padding()
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
            .foregroundColor(.blue)
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


