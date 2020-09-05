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
    
    @State var showSelections: Bool = false
    @State var showImagePicker: Bool = false
    @State var selectedArray: [String] = []
    @State var interestsArray: [String] = []
    @State var image: Image?
    @State var inputImage: UIImage?

    
    
    var body: some View {
        GeometryReader { geometry in
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Information")) {
                        HStack {
                            Text("ProjectName:")
                            TextField("Name", text: self.$projectViewModel.project.name)
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
                        //TextField("Title", text: self.$projectViewModel.project.homepage).disabled(true)
                        generateContent(in: geometry, selectedArray: self.selectedArray)
                    }
                    
                    
                    
                    Section(header: Text("Participants")) {
                        TextField("Title", text: self.$projectViewModel.project.description)
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
                            self.image == nil)
                )
            Selections(showSelections: self.$showSelections, selectedArray: self.$selectedArray, interestsArray: self.$interestsArray).zIndex(self.showSelections ? 1 : -1)

            
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
        setPicureOfProject()
        projectViewModel.save()
        dismiss()
    }
    
    func dismiss() {
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
    
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        self.image = Image(uiImage: inputImage)
    }
    
    func setPicureOfProject() {
        self.projectViewModel.project.picture = self.projectViewModel.project.name
        
        let storage = Storage.storage()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storage.reference().child("images/\(self.projectViewModel.project.picture).jpg").putData((inputImage?.jpegData(compressionQuality: 0.35)!)!, metadata: metadata) { (_, error) in
            
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Success")
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}
