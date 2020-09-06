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
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var profilesViewModel = ProfilesViewModel()
    
    @Binding var showEditProfile: Bool
    @State var profile: Profile = Profile(firstName: "", lastName: "", email: "", bio: "", title: "", projects: [], interests: [], picture: "")
    
    @State var test = false
    

    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("email:")) {
                    TextField("", text: self.$profile.email)
                }
                if self.test {
                Section(header: Text("email:")) {
                    TextField("", text: self.$profile.email)
                }
                }
            
            
            } // end of Form
            .navigationBarTitle("My Profile", displayMode: .inline)
                .navigationBarItems(leading:Button(action: { self.handleCancelTapped() }) {
                Text("Cancel")
                } , trailing: Button(action: {}) {
                    Text("Done")}
                    .disabled(self.profileViewModel.profile.email == "")
            )
            .onAppear(perform: getUserProfile)
        }.onAppear {
            self.profilesViewModel.fetchData()
        }
    }
    
    // MARK: -Data function
    func getUserProfile(){
        for profile in self.profilesViewModel.profiles {
            if profile.email == Auth.auth().currentUser?.email {
                self.profile = profile
                self.test = true
                return
            }
            
        }
    }
    
    
    // MARK: -Button function
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    
    

}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(showEditProfile: .constant(true))
    }
}
