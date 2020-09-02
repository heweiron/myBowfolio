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
    @State var isExpand = false
    @State var showEditProfile = false
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        



        Group {
            
            // TODO: change!!!!!!!!!!!!!!!!!!!!!
            if session.session == nil {

                   
                ZStack {
                    VStack {
                        
                        TopBar(selected: $selected, isExpand: $isExpand)
                        
                        MainPages(selected: $selected)
                        
                        
                        
                    }.edgesIgnoringSafeArea(.all)
                    
                    
                    
                    
                    if self.isExpand  {
                        
                        Rectangle().edgesIgnoringSafeArea(.all)
                            .foregroundColor(Color.black.opacity(0.01)).onTapGesture {
                                self.isExpand.toggle()
                        }
                        // pop out options menu
                        VStack(alignment: .leading) {
                            
                            
                            
                            Divider()
                            
                            Button(action: {
                                self.showEditProfile = true
                            }) {
                                Image(systemName: "person.circle").foregroundColor(.white)
                                Text("My Profile").foregroundColor(.white)
                            }
                            
                            
                            
                            
                            
                            Divider()
                            
                            Button(action: {
                                print("A")
                            }) {
                                Image(systemName: "plus.circle").foregroundColor(.white)
                                Text("Add Project").foregroundColor(.white)
                            }
                            
                            Divider()
                            
                            
                            
                            Button(action: {
                                self.session.signOut() ? print("Sign Out Successfully"): print("Error")
                                
                            }) {
                                Image(systemName: "person.crop.circle.badge.minus").foregroundColor(.white)
                                Text("Log Out").foregroundColor(.white)
                            }
                            
                            Divider()
                        
                    }.padding(.horizontal, 15)
                        .frame(width: UIScreen.main.bounds.width*0.4)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .offset(x: UIScreen.main.bounds.width/4, y: -UIScreen.main.bounds.height * 0.3)
                    }
                    
                    if self.showEditProfile {
                        EditProfileView(showEditProfile: $showEditProfile).transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom))).zIndex(1)
                    }
                    
                    
                    
                }
            } else {
                ContentView()
            }
        }.onAppear(perform: getUser)
        
    }
    
}

struct MainPages: View {
    
    @Binding var selected: Int
    var body: some View {
        
        Pages(currentPage: $selected, navigationOrientation: .horizontal, transitionStyle: .scroll, hasControl: false) { () -> [AnyView] in
            ProfilesView()
            ProjectsView()
            InterestsView()
            FilterView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SessionStore())
    }
}


struct TopBar: View {
    @Binding var selected: Int
    @Binding var isExpand: Bool
    @EnvironmentObject var session: SessionStore
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("logo").resizable()
                .frame(width: 50, height: 50)
                Text("Bowfolios").font(.system(size: 30)).fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                Spacer()
                

                
                VStack {
                    Button(action: {
                        self.isExpand.toggle()

                    }) {
                        Image(systemName: "person.circle").font(.system(size: 45)).foregroundColor(Color(#colorLiteral(red: 0.2486035228, green: 0.4458619356, blue: 0.3134422302, alpha: 1)))
                    }
                    
                    
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
