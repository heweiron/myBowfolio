//
//  SignUpView.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repassword: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    func signUp() {
        if self.password != self.repassword {
            alertMessage = "Passwords are not match, Please Re-Enter your passwords!"
            showAlert = true
        } else {
            session.signUp(email: email, password: password) { (result, error) in
                if error != nil {
                    self.showAlert = true
                    self.alertMessage = error?.localizedDescription ?? ""
                } else {
                    let user = User(email: self.email, displayName: "")
                    self.userViewModel.addUser(user: user)
                    self.profileViewModel.profile.email = self.email
                    self.profileViewModel.addProfile(profile: self.profileViewModel.profile)
                }
            }
        }
    }
    var body: some View {
        
        ZStack {
            VStack {
                // title
                Text("Register")
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Email")
                        Image(systemName:"envelope")
                    }
                    TextField("Please Enter your Email", text: $email)
                    Divider()
                    
                    HStack {
                        Text("Password")
                        Image(systemName:"lock")
                    }
                    TextField("Please Enter your Email", text: $password)
                    Divider()
                    
                    HStack {
                        Text("Password confirm")
                        Image(systemName:"lock")
                    }
                    TextField("Please re-enter your Email", text: $repassword)
                    Divider()
                    
                    
                }.padding().font(.system(size: 20))
                Spacer()
                Button(action: {
                    // TODO: check login status
                    self.signUp()
                }) {
                    DesignedButton(buttonText: "Sign Up")
                }
                
                Spacer()
                
                
            }.background(
                ZStack{
                    Rectangle().foregroundColor(Color(#colorLiteral(red: 0.8937863708, green: 0.9039856791, blue: 0.9527032971, alpha: 1))).edgesIgnoringSafeArea(.all)
                    Rectangle().foregroundColor(Color.white).rotationEffect(Angle(degrees: 76) )
                }
            )
            if showAlert {
                AlertView(showAlert: $showAlert, alertMessage: $alertMessage)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
