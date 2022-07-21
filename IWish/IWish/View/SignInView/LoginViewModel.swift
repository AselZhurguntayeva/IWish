//
//  SignInViewModel.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/20/22.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self]
            result, error in
            guard result != nil, error == nil else {
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self]
            result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signOut() {
       try? auth.signOut()
        self.signedIn = false
    }
}

