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
    
    @State var date: Date = Date ()
    @State var title: String = ""
    
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
                        .font(.custom("Kanit-Medium", size: 20))
                        .padding(20)
                }.frame(width: UIScreen.main.bounds.width - 30, height: 55, alignment: .leading)
                ZStack {
                    Rectangle().fill(.ultraThinMaterial)
                        .cornerRadius(12)
                    TextField("i.e. Christmas", text: $title)
                        .padding()
                }.frame(width: UIScreen.main.bounds.width - 30, height: 55)
                
                VStack{
                    ZStack(alignment: .leading) {
                        Text("Event date")
                            .font(.custom("Kanit-Medium", size: 20))
                            .padding(10)
                        Rectangle().fill(Color.clear)
                            .cornerRadius(12)
                    }
                    .frame(width: UIScreen.main.bounds.width - 30, height: 55, alignment: .leading)
                    Text(date, style: .date)
                    ZStack {
                        Rectangle().fill(.ultraThinMaterial)
                            .cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 300)
                        DatePicker("When is your occasion?", selection: $date, in: startingDate..., displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(width: 300, height: 300)
                    }
                    Spacer()
                }
                .labelsHidden()
                Button {
                        let title = title
                    wishListViewModel.createWishList(title: title, date: date)
                   dismiss()
                } label: {
                    Text(wishList == nil ? "Create" : "Cancel")
                        .font(.custom("Kanit-Light", size: 18))
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
                title = wishList.title
            }
        }
    }
}

struct CreateWishList_Previews: PreviewProvider {
    static var previews: some View {
        CreateWishList(wishListViewModel: WishListViewModel())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
