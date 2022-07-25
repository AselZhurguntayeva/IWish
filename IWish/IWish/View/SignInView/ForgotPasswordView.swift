//
//  ForgotPasswordView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/21/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var email = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(50)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                    .padding()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text ("Send password reset")
//                        .cornerRadius(10)
                    .frame(maxWidth:.infinity, maxHeight: 30)
//                    .frame(width: UIScreen.main.bounds.width - 60, height: 40)
                        .padding()
                   
                    
                }
                    .foregroundColor(.black)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray.opacity(0.25))
                        )
                    
            }.padding(.horizontal, 15)
            .navigationTitle("Reset Password")
            .toolbar {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                }.foregroundColor(.black)

            }
        }
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
