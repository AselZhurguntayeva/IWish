//
//  SignInView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/20/22.
//

import SwiftUI
import Firebase


struct LoginView: View {
    @EnvironmentObject var viewModel : LoginViewModel
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
        NavigationView{
            VStack{
                if self.status {
                    Homescreen()
                }
                else{
                    ZStack{
                        NavigationLink(destination: SignUpView(show: self.$show, viewModel: LoginViewModel()), isActive: self.$show) {
                            Text("")
                        }
                        .hidden()
                        SignInView(show: self.$show, viewModel: LoginViewModel())
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}
    
//    @State private var isSignedIn = false
    
//    var body: some View {
//        if isSignedIn {
//            WishListView()
//        } else {
//            content
//        }
//    }
//    var content: some View {
//    var body: some View {
//        NavigationView {
//            if viewModel.signedIn {
//                VStack {
//                        Text("You are successfully signed in")
//                        Button {
//                            viewModel.signOut()
//                        } label: {
//                            Text("Sign Out")
//                                .frame(width: 100, height: 40)
//                                .foregroundColor(Color.blue)
//                                .background(Color.green)
//                                .padding()
//                        }
//                    }
//                 WishListView() // instead of Vstack if sighedIn to go to WishListView
//            }
//                }
//            else {
//                SignInView()
//            }
//        }
//        .onAppear{
//            viewModel.signedIn = viewModel.isSignedIn
//        }
//    }
//}
struct SignInView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var showSheet: Bool = false
//    @State private var showForgotPassword = false
    
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
  
    @ObservedObject var viewModel : LoginViewModel
//    @EnvironmentObject var viewModel : LoginViewModel
    
    var body: some View {
        NavigationView{
        ZStack{
            ZStack(alignment: .topTrailing) {
                GeometryReader{_ in
                    Image("login1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    HStack {
                       Spacer()
                VStack {
                    Spacer()
                        TextField("Email Address", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            
                            
//                            SecureField("Password", text: $password)
//                                .disableAutocorrection(true)
//                                .autocapitalization(.none)
//                                .padding()
//                                .background(Color(.secondarySystemBackground))
//                                .cornerRadius(50)
//                        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                    HStack{
                        VStack{
                            if self.visible{
                                TextField("Password", text: $password)
                                    .autocapitalization(.none)
                            }
                            else{
                                SecureField("Password", text: $password)
                                    .autocapitalization(.none)
                            }
                        }
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.black.opacity(0.7))
                        }
                    }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .padding(.top, 25)
                    HStack{
                            Spacer()
                            Button{
//                                    viewModel.reset()
                                    self.reset()
                                } label: {
                                    Text("Forgot Password")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.black)
                                }
    //                            .padding(.top)
//                                .sheet(isPresented: $showForgotPassword) {
//                                    ForgotPasswordView()
                            }.padding(.top, 20)
                    Button(action: {
//                                viewModel.verify()
                        self.verify()
                    }) {
//                                    guard !email.isEmpty, !password.isEmpty else {
//                                        return
//                                    }
//                                    viewModel.signIn(email:email, password: password)
//                                } label: {
//                                    Text ("Sign In")
//                                    .foregroundColor(.black)
//                                    .frame(width: 200, height: 40)
//                                    .cornerRadius(12)
//                                    .background(Color(.systemGray5))
                                    
//                                    NavigationLink(destination: WishListView(), label: {
//                                        Text ("Sign In")
//                                            .foregroundColor(.black)
//                                            .frame(width: 200, height: 50)
//                                            .cornerRadius(12)
//                                        .background(Color(.systemGray5))
//                                    })
//
//                                    .navigationBarHidden(true)
                        NavigationLink(destination:WishListView(),
                    label:{
                            Text("Log in")
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        })
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .padding(.top)
                    }
                           
                    HStack{
                        Button(action: {
                            self.show.toggle()
                        }) {
                            Text("Register")
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                }
                        .padding()
                    }
            }
        }
                        .padding(.horizontal, 25)
    }
//                Button(action: {
//                    self.show.toggle()
//                }) {
//                    Text("Register")
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.black)
//        }
//                .padding()
    }
            if self.alert{
                ErrorView(viewModel: LoginViewModel(), alert: self.$alert, error: self.$error)
            }
        }
    }
}
    func verify(){
        if self.email != "" && self.password != ""{

            Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, err) in

                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    func reset(){
        if self.email != ""{
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
}
 

struct SignUpView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var repassword = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    @ObservedObject var viewModel : LoginViewModel
//    @EnvironmentObject var viewModel : LoginViewModel
//
    var body: some View {
        NavigationView {
            ZStack {
                    Image("wallpaper")// need to change pic here
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                ZStack(alignment: .topLeading) {
                    VStack {
                        Spacer()
                        Text("Create Account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black.opacity(0.7))
                            .padding(.top, 35)
                        
                        TextField("Email Address", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .padding(.top, 25)
                        HStack{
//                        SecureField("Password", text: $password)
//                            .disableAutocorrection(true)
//                            .autocapitalization(.none)
//                            .padding()
//                            .background(Color(.secondarySystemBackground))
                            
                            VStack{
                                if self.visible{
                                    TextField("Password", text: $password)
                                    .autocapitalization(.none)
                                }
                                else{
                                    SecureField("Password", text: $password)
                                    .autocapitalization(.none)
                                }
                            }
                            Spacer()
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.black.opacity(0.7))
                            }
                        }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .padding(.top, 25)
                       
                        HStack {
                                VStack{
                                    if self.revisible{
                                        TextField("Re-enter", text:$repassword)
                                        .autocapitalization(.none)
                                    }
                                    else{
                                        SecureField("Re-enter", text:$repassword)
                                        .autocapitalization(.none)
                                    }
                                }
                                Button(action: {
                                    self.revisible.toggle()
                                }) {
                                    Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.black.opacity(0.7))
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .padding(.top, 25)
                        Button{
//                            viewModel.signUp()
                            self.register()
                        }label: {
                            Text ("Done")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width:150, height: 50)
                            .cornerRadius(12)
                            .background(.black)
                            .padding(.top)
                        }.padding()
//                            NavigationLink(destination: WishListView(), label: {
//                            Text ("Done")
//                                .foregroundColor(.white)
//                                .fontWeight(.semibold)
//                                .frame(width:150, height: 50)
//                                .cornerRadius(12)
//                                .background(.black)
//                            })
                        Spacer()
                        }
                 
                    Spacer()
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(Color.black)
                        }
                    }
                if self.alert{
                    ErrorView(viewModel: LoginViewModel(), alert: self.$alert, error: self.$error)
                }
                Spacer()
            }
           Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
    func register(){
        if self.email != ""{
            if self.password == self.repassword{

                Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err) in

                    if err != nil{

                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    print("success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}
struct ErrorView : View {
    @ObservedObject var viewModel : LoginViewModel
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View{
        GeometryReader{_ in
            VStack{
                HStack{
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 25)
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(.black)
                .padding(.top)
                .padding(.horizontal, 25)
                Button(action: {
                    self.alert.toggle()
                }) {
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color.black)
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}

struct Homescreen : View {
    var body: some View{
        VStack{
            Text("Logged successfully")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.7))
            Button(action: {
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color.gray)
            .cornerRadius(10)
            .padding(.top, 25)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
