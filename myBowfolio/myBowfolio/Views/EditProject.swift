//
//  EditProject.swift
//  myBowfolio
//
//  Created by weirong he on 9/5/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct EditProject: View {
    @ObservedObject private var profileViewModel = ProfileViewModel()
    @ObservedObject private var profilesViewModel = ProfilesViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                self.profileViewModel.profile.email = Auth.auth().currentUser?.email ?? ""
                self.profileViewModel.profile.firstName = "Wei"
                self.profileViewModel.profile.lastName = "Wong"
                print(self.profileViewModel.profile.email)
            }) {
                Text("Add")
            }
            
            Button(action: {
                self.profileViewModel.save()
            }) {
                Text("Done")
            }
            
            Button(action: {
                for profile in self.profilesViewModel.profiles {
                    if profile.email == "wei@email.com" {

                    print("email: \(profile.email)")
                    print("name: \(profile.firstName)")
                    print("id: \(profile.id ?? "no")")
                    
                    print(profile.id ?? "no id")
                }
                    
                }
            }) {
                Text("Print")
            }
            
        }.onAppear {
            self.profilesViewModel.fetchData()
        }
    }
}

struct EditProject_Previews: PreviewProvider {
    static var previews: some View {
        EditProject()
    }
}
