//
//  HomeView.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import Pages

struct HomeView: View {
    
    @State var index = 0
    
    var profile: Project
    var body: some View {
        
//        Pages(currentPage: $index) { () -> [AnyView] in
//            Text("1")
//            Text("2")
//        }
        
        VStack {
            TopBar()
            Spacer()
        }.edgesIgnoringSafeArea(.all)

        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(profile: projectData[2])
    }
}


struct TopBar: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("logo").resizable()
                .frame(width: 50, height: 50)
                Text("Bowfolios").font(.system(size: 30)).fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                Spacer()
                
                
            }
            
            HStack{
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Profiles").fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Projects").fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Interests").fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Add Project").fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Filter").fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                
            }
           
        }.padding()
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
            .background(Color(#colorLiteral(red: 0.910528481, green: 0.9875190854, blue: 0.9374515414, alpha: 1)))
    }
}
