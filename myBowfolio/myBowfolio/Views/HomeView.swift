//
//  HomeView.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import Pages
import Firebase

struct HomeView: View {
    
    @State var index = 0
    @State var selected = 0
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        
        
        Group {
            if session.session != nil {
                VStack {
                    TopBar(selected: $selected)
                    
                    // TODO: Change to actuall view
                    
                    Pages(currentPage: $selected, navigationOrientation: .horizontal, transitionStyle: .scroll, hasControl: false) { () -> [AnyView] in
                        ProfilesView()
                        ProjectsView()
                        InterestsView()
                        FilterView()
                    }
                    
                }.edgesIgnoringSafeArea(.all)
            } else {
                ContentView()
            }
        }.onAppear(perform: getUser)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SessionStore())
    }
}


struct TopBar: View {
    @Binding var selected: Int
    @EnvironmentObject var session: SessionStore
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("logo").resizable()
                .frame(width: 50, height: 50)
                Text("Bowfolios").font(.system(size: 30)).fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                Spacer()
                
                Button(action: {
                    self.session.signOut() ? print("Sign Out Successfully"): print("Error")
                    
                }) {
                    Text("Log Out")
                }
                
            }
            
            HStack{
                Button(action: {
                    self.selected = 0
                }) {
                    Text("Profiles").fontWeight(.semibold).foregroundColor(
                        self.selected == 0 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                Spacer()
                Button(action: {
                    self.selected = 1
                }) {
                    Text("Projects").fontWeight(.semibold).foregroundColor(self.selected == 1 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                Spacer()
                Button(action: {
                    self.selected = 2
                }) {
                    Text("Interests").fontWeight(.semibold).foregroundColor(self.selected == 2 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                Spacer()
                Button(action: {
                    self.selected = 3
                }) {
                    Text("Filter").fontWeight(.semibold).foregroundColor(self.selected == 3 ? Color(#colorLiteral(red: 0.4268223047, green: 0.5645358562, blue: 0.9971285462, alpha: 1)) : Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                }
                
            }
           
        }.padding()
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
            .background(Color(#colorLiteral(red: 0.910528481, green: 0.9875190854, blue: 0.9374515414, alpha: 1)))
        .shadow(radius: 20)
    }
}
