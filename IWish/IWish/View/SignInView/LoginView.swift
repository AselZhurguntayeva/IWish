//
//  SignInView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/20/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel : LoginViewModel
    
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                VStack {
                        Text("You are signed in")
                        Button {
                            viewModel.signOut()
                        } label: {
                            Text("Sign Out")
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color.blue)
                                .background(Color.green)
                                .padding()
                        }
                    }
                }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var showSheet: Bool = false
  
    @EnvironmentObject var viewModel : LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                    Image("login1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        TextField("Email Address", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .padding()
                            
                        SecureField("Password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                        Button {
                            guard !email.isEmpty, !password.isEmpty else {
                                return
                            }
                            viewModel.signIn(email:email, password: password)
                        } label: {
                            NavigationLink(destination: WishListView(), label: {
                                Text ("Sign In")
                                    .foregroundColor(.black)
                                    .frame(width: 200, height: 50)
                                    .cornerRadius(12)
                                .background(Color(.systemGray5))
                            })
                            .navigationBarHidden(true)
                        }
                        .padding()
                        NavigationLink("New around here? Sign Up", destination: SignUpView())
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                    }.navigationBarHidden(true)
                    .padding()
                    Spacer()
                }
            .navigationBarHidden(true)
            
        }
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel : LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                    Image("logo")// need to change pic here
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    VStack {
                        TextField("Email Address", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                        SecureField("Email Address", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                        
                        Button {
                            guard !email.isEmpty, !password.isEmpty else {
                                return
                            }
                            viewModel.signUp(email: email, password: password)
                        } label: {
                            NavigationLink(destination: WishListView(), label: {
                            Text ("Create Account")
                                .foregroundColor(.black)
                                .frame(width: 200, height: 50)
                                .cornerRadius(8)
                                .background(Color(.systemGray5))
                        })
                            
                    }
                }
                    .navigationBarHidden(true)
                    .padding()
                    Spacer()
                }
//            .navigationTitle("Create Account")
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
