//
//  ContentView.swift
//  myBowfolio
//
//  Created by weirong he on 8/28/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import Pages

struct ContentView: View {
    @State var index: Int = 0
    @State var isLogin: Bool = false
    var body: some View {
        NavigationView {
            
            
            
            VStack (spacing: 20){
                Image("logo")
                
                // introduction of the app scroll view
                
                Pages(currentPage: $index, navigationOrientation: .horizontal, transitionStyle: .scroll, bounce: true, wrap: false, hasControl: true, controlAlignment: .bottom) { () -> [AnyView] in
                    ZStack {
                        HStack {
                            Image("editProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Image("profileView")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                        }
                        
                        Text("  Making your profile  ").fontWeight(.semibold).font(.system(size: 38)).background(Color.black.opacity(0.3)).rotationEffect(Angle(degrees: 20)).foregroundColor(.white)
                    }
                    ZStack {
                        HStack {
                            Image("interestView")
                                .resizable().aspectRatio(contentMode: .fit)
                            Image("filterView")
                            .resizable().aspectRatio(contentMode: .fit)
                        }
                        Text("  Adding your projects  ").fontWeight(.semibold).font(.system(size: 38)).background(Color.black.opacity(0.3)).rotationEffect(Angle(degrees: -20)).foregroundColor(.white)
                    }
                    ZStack {
                        HStack {
                            Image("addProject")
                                .resizable().aspectRatio(contentMode: .fit)
                            Image("editProfile")
                            .resizable().aspectRatio(contentMode: .fit)
                        }
                        Text("connect to people with shared interests!").fontWeight(.semibold).font(.system(size: 38)).multilineTextAlignment(.center).background(Color.black.opacity(0.3)).foregroundColor(.white)
                    }
                }.frame(height: 300)
                
                
                // Title
                VStack {
                    Text("Welcome To Bowfolios")
                        .font(.largeTitle).fontWeight(.heavy)
                    Text("Profiles, projects, and interest areas for the UH Community")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }.padding()
                
                // Log in button to the login view
                NavigationLink(destination: LoginView()) {
                    
                    
                    DesignedButton(buttonText: "Login")
                    
                }
                
                
                
                
            }.frame(maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(
                    ZStack{
                        Rectangle().foregroundColor(Color(#colorLiteral(red: 0.8937863708, green: 0.9039856791, blue: 0.9527032971, alpha: 1))).edgesIgnoringSafeArea(.all)
                        Rectangle().foregroundColor(Color.white).rotationEffect(Angle(degrees: 76) )
                    }
            )
            
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
