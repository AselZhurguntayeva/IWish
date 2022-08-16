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
    
    var body: some View {
        
     NavigationView {
            VStack {
                HStack {
                    Text("My Wish Lists")
                        .font(.custom("Kanit-SemiBold", size: 30))
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showSheet.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                                .padding()
                        })
                        .fullScreenCover(isPresented: $showSheet, content: { CreateWishList(wishListViewModel: wishListViewModel)
                        })
                    }
                }
                .navigationBarItems(leading:
            Button(action: {
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                     }, label: {
                Text("Log out")
                .font(.custom("Kanit-Light", size: 16))
                .foregroundColor(.blue)
                     })
                )
               Spacer()
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
                                    .foregroundColor(Color.blue)
                                    .padding(.trailing)
                            }
                                VStack{
                                Text(item.title)
                                    .font(.custom("Kanit-Medium", size: 18))
                                    .padding(.bottom, 5)
                               
                                Text(wishListViewModel.getDateOfWishList(date: item.date))
                                    .font(.custom("Kanit-Regular", size: 16))
                                    .font(.subheadline)
                                    .padding(.bottom, 5)
                                Text("Total wishes: \(item.items.count)")
                                    .font(.custom("Kanit-Light", size: 16))
                                }

                            }

                        }
                        .padding()
                    }
                        .onDelete(perform: wishListViewModel.deleteWishList(at:))
            }
                    .listStyle(.plain)
        }
    }
           
       
        } .navigationBarHidden(true)
    }
}
    
struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WishListView()
        }
    }
}


