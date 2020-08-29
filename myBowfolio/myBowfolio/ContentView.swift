//
//  ContentView.swift
//  myBowfolio
//
//  Created by weirong he on 8/28/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Rectangle().foregroundColor(Color(#colorLiteral(red: 0.8937863708, green: 0.9039856791, blue: 0.9527032971, alpha: 1))).edgesIgnoringSafeArea(.all)
            Rectangle().foregroundColor(Color.white).rotationEffect(Angle(degrees: 76) )
        VStack (spacing: 20){
                Image("logo")
            
            // introduction of the app scroll view
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack{
                    
                    // TODO: change image to the screenshot of this app
                    Image("projects-page")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("projects-page")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
            Button(action: {
                // TODO: direct to login view
            }) {
                DesignedButton(buttonText: "Login")
            }
            
        
            
        }.frame(maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
