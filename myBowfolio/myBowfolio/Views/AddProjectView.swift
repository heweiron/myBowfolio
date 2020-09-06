//
//  AddProjectView.swift
//  myBowfolio
//
//  Created by weirong he on 9/2/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct AddProjectView: View {
    
    @ObservedObject var projectViewModel = ProjectViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var profilesViewModel = ProfilesViewModel()
    @ObservedObject private var projectsViewModel = ProjectsViewModel()
    @ObservedObject private var usersViewModel = UsersViewModel()
    
    @State var showSelections: Bool = false
    @State var showImagePicker: Bool = false
    @State var showParticipants: Bool = false
    @State var selectedArray: [String] = []
    @State var selectedParticipantsArray: [String] = []
    @State var interestsArray: [String] = []
    @State var usersArray: [String] = []
    @State var image: Image?
    @State var inputImage: UIImage?
    @State var imageUrl = ""
    
    @Binding var showAddProject: Bool

    
    
    var body: some View {
        GeometryReader { geometry in
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Information")) {
                        HStack {
                            Text("ProjectName:")
                            TextField("Name", text: self.$projectViewModel.project.name)
                            if !self.checkNameToBeIdentical(name: self.projectViewModel.project.name) {
                                Text("This name is already in use").foregroundColor(Color.red)
                            }
                        }
                        HStack {
                            Text("HomePage:   ")
                            TextField("HomePage", text: self.$projectViewModel.project.homepage)
                        }
                        HStack {
                            Text("Description:  ")
                            TextField("Description", text: self.$projectViewModel.project.description)
                        }
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
                        generateContent(in: geometry, selectedArray: self.selectedArray)
                    }
                    
                    
                    
                    Section(header: HStack {
                        Text("Participants")
                        Button(action: {
                            self.showParticipants = true
                            self.usersArray = self.getUsers()
                        }) {
                            Image(systemName: "plus.circle").font(.system(size: 18))
                        }
                        
                    }) {
                        generateContent(in: geometry, selectedArray: self.selectedParticipantsArray)
                    }
                    
                    
                    
                    
                    Section(header:
                        Text("")
                    ) {
                            HStack {
                                Text("Picture:")
                                Spacer()
                                if self.image != nil {
                                    self.image?.resizable().frame(width: 100, height: 100)
                                } else {
                                    Image("default").resizable().frame(width: 100, height: 100)
                                }
                                Image(systemName: "chevron.right")
                            }.onTapGesture {
                                    self.showImagePicker = true
                            }
                        
                    }
                    
                    
                    
                    
                }
                .navigationBarTitle("New Project", displayMode: .inline)
                .navigationBarItems(leading:Button(action: { self.handleCancelTapped() }) {
                    Text("Cancel")
                    } , trailing: Button(action: { self.handleDoneTapped() }) {
                        Text("Done")}
                        .disabled(self.projectViewModel.project.name.isEmpty || self.projectViewModel.project.homepage.isEmpty || self.projectViewModel.project.description.isEmpty ||
                            self.selectedArray.count <= 0 ||
                            self.image == nil ||
                            self.checkNameToBeIdentical(name: self.projectViewModel.project.name) == false)
                )
                
                // Selections of Interests
            Selections(showSelections: self.$showSelections, selectedArray: self.$selectedArray, itemsArray: self.$interestsArray).zIndex(self.showSelections ? 1 : -1)
                
            // Selections for participants
            Selections(showSelections: self.$showParticipants, selectedArray: self.$selectedParticipantsArray, itemsArray: self.$usersArray).zIndex(self.showParticipants ? 1 : -1)
            

            
            } // end of ZStack
                .onAppear() {
                    self.projectsViewModel.fetchData()
                    self.profilesViewModel.fetchData()
            }
        }.sheet(isPresented: self.$showImagePicker, onDismiss: self.loadImage) {
            ImagePicker(show: self.$showImagePicker, image: self.$inputImage)
            }
    }
}
    
    
    // MARK: Button methods
    
    func handleCancelTapped() {
        dismiss()
    }
    
    func handleDoneTapped() {
        setInterests()
        setParticipants()
        setPicureOfProject()
        projectViewModel.save()
        dismiss()
    }
    
    func dismiss() {
        self.showAddProject = false
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: Data methods
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
    
    func setInterests() {
        self.projectViewModel.project.interests = self.selectedArray
    }
    
    func getUsers() -> [String] {
        var usersArray: [String] = []
        
        for profile in profilesViewModel.profiles {
            usersArray.append(profile.email)
        }
        
        return usersArray
    }
    
    
    func setParticipants() {
        for user in self.selectedParticipantsArray {
            for profile in self.profilesViewModel.profiles {
                if profile.email.lowercased() == user.lowercased() {
                    
                    self.profilesViewModel.addOneProject(projectName: self.projectViewModel.project.name, email: profile.email)
                    
                }
            }
        }
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        self.image = Image(uiImage: inputImage)
    }
    
    func setPicureOfProject() {
        
        let storage = Storage.storage()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storage.reference().child("projectImages/\(self.projectViewModel.project.name).jpg").putData((inputImage?.jpegData(compressionQuality: 0.35)!)!, metadata: metadata) { (_, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Upload project image Successfully")
        }
    }
    
    
    
    
    func checkNameToBeIdentical(name: String) -> Bool {
        for project in self.projectsViewModel.projects {
            if project.name == name.trimmingCharacters(in: .whitespacesAndNewlines) {
                return false
            }
        }
        return true
    }
    
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(showAddProject: .constant(true))
    }
}
