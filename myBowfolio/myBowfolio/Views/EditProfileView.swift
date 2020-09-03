//
//  EditProfileView.swift
//  myBowfolio
//
//  Created by weirong he on 9/2/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import Firebase

struct EditProfileView: View {
    
    @ObservedObject var profilesViewModel = ProfilesViewModel()
    @ObservedObject var session = SessionStore()
    
    @Binding var showEditProfile: Bool

    @State private var email: String = "sin8@hawaii.edu"
    @State private var firstName: String = ""
    @State private var lastName: String = "jjj"
    @State private var bio: String = "hhggg"
    @State private var title: String = ""
    @State private var picture: String = ""
    @State private var interests: [String] = []
    @State private var projects: [String] = []
    

    
    
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                Button(action: {
                    self.showEditProfile = false
                }) {
                    Text("Done")
                }

            }.padding()
            
            VStack(alignment: .leading) {
                Text("Email")
                TextField("text #1", text: $email)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("First Name")
                TextField("text #1", text: $firstName)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("Last Name")
                TextField("text #1", text: $lastName)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("Title")
                TextField("text #1", text: $title)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("Biographical statement")
                TextField("text #1", text: $bio)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("Interests")
                HStack {
                    Text(" ")
                    Spacer()
                    Image(systemName: "chevron.down")
                }.padding(.horizontal)
                Divider()
            }
            
            Spacer()
            
        }.padding()
            .onAppear() {
                self.profilesViewModel.fetchData()
                self.getMyProfile()
        }
            

        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8474698663, green: 0.9006587863, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
    .cornerRadius(35)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.linear)
    }
    
    
    func getMyProfile() {
        self.profilesViewModel.fetchData()
        for profile in profilesViewModel.profiles {
            if profile.email == self.email {
                self.firstName = profile.firstName
                self.lastName = profile.lastName
                self.title = profile.title
                self.bio = profile.bio
                self.interests = profile.interests
                self.projects = profile.projects
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(showEditProfile: .constant(true))
    }
}
