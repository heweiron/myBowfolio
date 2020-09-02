//
//  LoginView.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var alertMessage: String = ""
    @State var isLoading: Bool = false
    @State var isSuccessful = false
    @State var showAlert = false
    @State var isFocused = false
    @State var visible = false
    
    @EnvironmentObject var session: SessionStore
    
    
    func login() {
        session.signIn(email: email, password: password) { (result, error) in
            self.isLoading = false
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            } else {
                // self.isSuccessful = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isSuccessful = false
                }
            }
        }
    }
    
    var body: some View {
        

            ZStack {
                VStack {
                    Spacer()
                    // title
                    Text("LOGIN")
                        .font(.largeTitle)
                    VStack(alignment: .leading, spacing: 20) {
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
                        
                        HStack {
                            if self.visible {
                                TextField("Please Enter your Email", text: $password)
                            } else {
                                SecureField("Please Enter your Email", text: $password)
                            }
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.fill" :"eye.slash.fill").foregroundColor(Color(#colorLiteral(red: 0.4651941061, green: 0.6181902885, blue: 1, alpha: 1)))
                            }
                        }
                        Divider()
                        
                        
                    }.padding().font(.system(size: 20))
                    
                    Button(action: {
                        // TODO: check login status
                        self.login()
                        
                    }) {
                        DesignedButton(buttonText: "Sign In")
                    }
                    
                    Spacer()
                    // sign up option
                    HStack {
                        Text("Don't have an account?")
                        
                        NavigationLink(destination: SignUpView().environmentObject(SessionStore())) {
                            Text("Sign Up").foregroundColor(Color.blue)
                        }
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
