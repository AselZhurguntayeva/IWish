//
//  IWishApp.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/13/22.
//

import SwiftUI
import Firebase

@main
struct IWishApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = LoginViewModel()
            LoginView().environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
   
      FirebaseApp.configure()

    return true
  }
}


