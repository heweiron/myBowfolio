//
//  EditProfileView.swift
//  myBowfolio
//
//  Created by weirong he on 9/2/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import Firebase
import SDWebImageSwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var profilesViewModel = ProfilesViewModel()
    @ObservedObject var projectsViewModel = ProjectsViewModel()
    
    @Binding var showEditProfile: Bool
    @State var profile: Profile
    @State var showSelections = false
    @State var showProjectSelections = false
    @State var interestsArray: [String] = []
    @State var projectsArray: [String] = []
    @State var image: Image?
    @State var inputImage: UIImage?
    @State var imageUrl = ""
    @State var showImagePicker = false
    @State var isLoadImage = false
    
    

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Form {
                        Section(header: Text("Email:")) {
                            TextField("ERROR", text: self.$profile.email).disabled(true)
                        }
                        
                        Section(header: Text("Name:")) {
                            HStack {
                                Text("First Name:")
                                TextField("Enter your first name", text: self.$profile.firstName)
                            }
                            HStack {
                                Text("Last Name:")
                                TextField("Enter your last name", text: self.$profile.lastName)
                            }
                            HStack {
                                Text("Title:")
                                TextField("Enter your title", text: self.$profile.title)
                            }
                        }
                        
                        Section(header: Text("Biographical statement:")) {
                            
                            //TextField("Enter your biographical statement", text: self.$profile.bio)
                            MutiLineTextField(text: self.$profile.bio).frame(height: 100)
                        }
                        
                        Section(header: HStack {
                            Text("Interests")
                            Button(action: {
                                self.showSelections = true
                                self.interestsArray = self.getInterests()
                            }) {
                                Image(systemName: "plus.circle").font(.system(size: 18))
                            }
                            
                        }) {
                            generateContent(in: geometry, selectedArray: self.profile.interests)
                        }
                        
                        
                        Section(header: HStack {
                            Text("Projects")
                            Button(action: {
                                self.showProjectSelections = true
                                self.projectsArray = self.getProjects()
                            }) {
                                Image(systemName: "plus.circle").font(.system(size: 18))
                            }
                            
                        }) {
                            generateContent(in: geometry, selectedArray: self.profile.projects)
                        }
                        
                        // Image Section
                        Section(header:
                            Text("")
                        ) {
                            HStack {
                                Text("Picture:")
                                Spacer()
                                if self.image != nil {
                                    self.image?.resizable().frame(width: 100, height: 100)
                                } else {
                                    if self.profile.picture == "" {
                                        Image("default").resizable().frame(width: 100, height: 100)
                                    } else {
                                        WebImage(url: URL(string: self.profile.picture)).resizable().frame(width: 100, height: 100)
                                    }
                                }
                                Image(systemName: "chevron.right")
                            }.onTapGesture {
                                self.showImagePicker = true
                            }
                            .sheet(isPresented: self.$showImagePicker, onDismiss: self.loadImage) {
                            ImagePicker(show: self.$showImagePicker, image: self.$inputImage)
                            }
                            
                        }
                        
                        
                        
                        
                    } // end of Form
                        .navigationBarTitle("My Profile", displayMode: .inline)
                        .navigationBarItems(leading:Button(action: { self.handleCancelTapped() }) {
                            Text("Cancel")
                            } , trailing: Button(action: { self.handleDoneTapped() }) {
                                Text("Done")}
                    )
                    // selection of interests
                    Selections(showSelections: self.$showSelections, selectedArray: self.$profile.interests, itemsArray: self.$interestsArray).zIndex(self.showSelections ? 1 : -1)
                    
                    
                    // selection of projects
                    Selections(showSelections: self.$showProjectSelections, selectedArray: self.$profile.projects, itemsArray: self.$projectsArray).zIndex(self.showProjectSelections ? 1 : -1)
                    
                    
                } // ZStack end
                    .onAppear {
                        self.profilesViewModel.fetchData()
                        self.projectsViewModel.fetchData()
                }
            } // Navigatong View end
        } // geometryReader end
    }
    
    // MARK: -Data function
    func getInterests() -> [String] {
        var interestsArray: [String] = []
        
        //for profile in profilesViewModel.profiles {
        for profile in profilesViewModel.profiles {
            for interest in profile.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }
        
        //for project in projectsViewModel.projects {
        for project in projectsViewModel.projects {
            for interest in project.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }
        
        return interestsArray
        
    }
    
    
    func getProjects() -> [String] {
        var projectsArray:[String] = []
        
        for project in projectsViewModel.projects {
            projectsArray.append(project.name)
        }
        return projectsArray
    }
    
    // MARK: -Button function
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        if image != nil {
            uploadPicureToStorage()
        }
        profilesViewModel.save(profile: profile, isUploadImage: isLoadImage)
        dismiss()
    }
    
    func dismiss() {
        self.showEditProfile = false
        presentationMode.wrappedValue.dismiss()
    }

    
    
    //MARK: -Image function
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        self.image = Image(uiImage: inputImage)
    }
    
    func uploadPicureToStorage() {
        
        let storage = Storage.storage()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storage.reference().child("profileImages/\(self.profile.email.lowercased()).jpg").putData((inputImage?.jpegData(compressionQuality: 0.35)!)!, metadata: metadata) { (_, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("load profile image Successfully")
            self.isLoadImage = true
            self.profilesViewModel.save(profile: self.profile, isUploadImage: self.isLoadImage)
        }
    }
    
    
    

}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(showEditProfile: .constant(true), profile: profileData[0])
    }
}
