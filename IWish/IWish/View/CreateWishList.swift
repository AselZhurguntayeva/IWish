//
//  createWishList.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI

struct CreateWishList: View {
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedDate: Date = Date()
    @State var titleText: String = ""
    @State var date: Date
    //@StateObject private var wishListViewModel = WishListViewModel()
    @ObservedObject var wishListViewModel: WishListViewModel
    var wishList: WishList?
    
    let startingDate: Date = .now
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Spacer()
                    Rectangle().fill(Color.clear)
                    Text("Title")
                        .frame( maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .padding(20)
                    
                }.frame(width: UIScreen.main.bounds.width - 30, height: 55, alignment: .leading)
                ZStack {
                    Rectangle().fill(.ultraThinMaterial)
                        .cornerRadius(12)
                    TextField("i.e. Christmas", text: $titleText)
                        .padding()
                }.frame(width: UIScreen.main.bounds.width - 30, height: 55)
                
                VStack{
                    ZStack(alignment: .leading) {
                        Text("Event date")
                            .font(.title3)
                            .padding(10)
                        Rectangle().fill(Color.clear)
                            .cornerRadius(12)
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 55, alignment: .leading)
                    //                        Text(selectedDate, style: .date)
                    
                    ZStack {
                        Rectangle().fill(.ultraThinMaterial)
                            .cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 300)
                        DatePicker("When is your occasion?", selection: $selectedDate, in: startingDate..., displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(width: 300, height: 300)
                    }
                    Spacer()
                    
                }
                .labelsHidden()
                Button {
//                    if wishList == nil
//                    {
//                        prepareForCreateWishList(title: titleText, date: selectedDate)
//                    guard
                        let title = titleText
//                    , !title.isEmpty
//                    else { return }
                    let wishList = WishList(title: title)
                
                    wishListViewModel.createWishList(title: title, date: date, wishList: wishList, wishListViewModel: wishListViewModel)
//                    } else { return }
                   dismiss()
                } label: {
                    Text(wishList == nil ? "Create" : "Cancel")
                }.padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
            
        }
        
        .onAppear {
            if let wishList = wishList {
                titleText = wishList.title
            }
        }
    }
//    func prepareForCreateWishList(title: String?
//                                  , date: Date?
//    ) {
//        guard let title = title, !title.isEmpty
//        else {return}
//        let wishList = WishList(title: title)
//        wishListViewModel.createWishList(wishList)
//    }
}

struct CreateWishList_Previews: PreviewProvider {
    static var previews: some View {
        CreateWishList(date: Date(), wishListViewModel: WishListViewModel())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
