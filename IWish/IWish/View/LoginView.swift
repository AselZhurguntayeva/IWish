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
                    WishListView()
//                    ContentView()
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
    
struct SignInView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var showSheet: Bool = false

    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
  
    @ObservedObject var viewModel : LoginViewModel
    
    var body: some View {
        ZStack{
            ZStack(alignment: .topTrailing) {
                GeometryReader{_ in
                    VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 35)
                        Text("Log in to your account")
                            .font(.custom("Kanit-SemiBold", size: 24))
                            .foregroundColor(.black)
                            .padding(.top, 35)
                        
                        TextField("Email Address", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .font(.custom("Kanit-ExtraLight", size: 18))
                            .padding(.bottom)
                    HStack{
                        VStack{
                            if self.visible{
                                TextField("Password", text: $password)
                                    .autocapitalization(.none)
                                    .font(.custom("Kanit-ExtraLight", size: 18))
                            }
                            else{
                                SecureField("Password", text: $password)
                                    .autocapitalization(.none)
                                    .font(.custom("Kanit-ExtraLight", size: 18))
                            }
                        }
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.primary)
                        }
                    }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                            .padding(.top)
                            HStack{
                       Spacer()
                            Button{
                                    self.reset()
                                } label: {
                                    Text("Forgot Password")
                                        .font(.custom("Kanit-Medium", size: 14))
                                        .foregroundColor(.primary)
                                } .padding(.trailing, 35)
                            .padding(.bottom)
                            }.padding(.top)
                    Button(action: {
                        self.verify()
                    }) {
                            Text("Log in")
                            .foregroundColor(.blue)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .font(.custom("Kanit-Light", size: 18))
                        }
                        HStack{
                            Spacer()
                        Button(action: {
                            self.show.toggle()
                        }) {
                            Text("Register")
                                .font(.custom("Kanit-Medium", size: 14))
                                .foregroundColor(.primary)
                }
                        .padding(.trailing, 35)
            }
        }
    }
}
            Spacer()
            if self.alert{
                ErrorView(viewModel: LoginViewModel(), alert: self.$alert, error: self.$error)
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

    var body: some View {

        ZStack(alignment:.topLeading) {
                VStack {
                    Image("gift1")
                        .resizable()
                        .frame(width: 250, height: 250)
                    Text("Create account")
                        .font(.custom("Kanit-SemiBold", size: 24))
                        .foregroundColor(.blue)
                        .padding(.top, 35)
                        .padding()
                    TextField("Email Address", text: $email)
                        .font(.custom("Kanit-ExtraLight", size: 18))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(50)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                        .padding()
                HStack{
                    VStack{
                        if self.visible{
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                                .font(.custom("Kanit-ExtraLight", size: 18))
                        }
                        else{
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                                .font(.custom("Kanit-ExtraLight", size: 18))
                        }
                    }
                    Button(action: {
                        self.visible.toggle()
                    }) {
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.primary)
                    }
                }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(50)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                        .padding()

                HStack{
                    VStack{
                        if self.revisible{
                            TextField("Re-enter", text: $repassword)
                            .autocapitalization(.none)
                            .font(.custom("Kanit-ExtraLight", size: 18))
                        }
                        else{
                            SecureField("Re-enter", text: $repassword)
                            .autocapitalization(.none)
                            .font(.custom("Kanit-ExtraLight", size: 18))
                        }
                    }
                        Button{
                            self.revisible.toggle()
                            } label: {
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.primary)
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(50)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 40)
                        .padding()
                Button(action: {
                    self.register()
                }) {
                        Text("Register")
                        .foregroundColor(.blue)
                        .font(.custom("Kanit-Light", size: 18))
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.leading)
                        .padding(.top)
                        .padding(.trailing)
                    }
                    Spacer()
                }
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.blue)
        }
            Spacer()
        if self.alert{
            ErrorView(viewModel: LoginViewModel(), alert: self.$alert, error: self.$error)
        }
    }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
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
    ZStack{
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
                        .font(.custom("Kanit-Light", size: 18))
                }
                .background(Color.black.opacity(0.70))
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
           
            .cornerRadius(25)
    }.background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
