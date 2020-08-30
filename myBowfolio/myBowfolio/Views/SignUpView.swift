//
//  SignUpView.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack {
                   Rectangle().foregroundColor(Color(#colorLiteral(red: 0.8937863708, green: 0.9039856791, blue: 0.9527032971, alpha: 1))).edgesIgnoringSafeArea(.all)
                   Rectangle().foregroundColor(Color.white).rotationEffect(Angle(degrees: 76) )
                   VStack{
                       Spacer()
                       // title
                       Text("Register")
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
                           TextField("Please Enter your Email", text: $password)
                           Divider()
                        
                        HStack {
                            Text("Password confirm")
                            Image(systemName:"lock")
                        }
                        TextField("Please re-enter your Email", text: $password)
                        Divider()
                           
                           
                       }.padding().font(.system(size: 20))
                       
                       Button(action: {
                           // TODO: check login status
                       }) {
                           DesignedButton(buttonText: "Sign Up")
                       }
                       
                       Spacer()
                       
                   }
               }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
