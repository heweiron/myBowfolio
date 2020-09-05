//
//  ProfileCard.swift
//  myBowfolio
//
//  Created by weirong he on 8/30/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct ProfileCard: View {
    
    var profile: Profile
    @ObservedObject var projectsViewModel = ProjectsViewModel()
    @State var url = ""

    var body: some View {
        
        VStack(spacing: 20) {
            
            HStack {
                VStack(spacing: 20) {
                    // Title
                    Text("\(profile.firstName) \(profile.lastName)").fontWeight(.bold)
                    Text(profile.title).foregroundColor(Color.black.opacity(0.6))
                }
                if url != "" {
                    WebImage(url: URL(string: url)).resizable().frame(width: 100, height: 100)
                } else {
                    Loader()
                }
            }.onAppear(perform: loadImageFromStorage)
            
            // description
            Text("\(profile.bio)").font(.subheadline).foregroundColor(Color.black).fixedSize(horizontal: false, vertical: true)
            Divider()
            
            // interests
            
             //make interests scrollable so that they can poresent in the the fix height
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(profile.interests, id: \.self) {interest in
                        Text("  \(interest)  ")
                            .fontWeight(.semibold)
                            .background(Color(#colorLiteral(red: 0.4046664238, green: 0.82443887, blue: 0.5267766118, alpha: 1)))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)


                    }
                }
            }
            
            Divider()
            // Projects
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Projects").fontWeight(.semibold)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(profile.projects, id: \.self) { project in
                            
                            // TODO: change it to image later
                            Text(self.getProject(projectName: project).name)
                        }
                    }
                }
                
            }.onAppear() {
                self.projectsViewModel.fetchData()
            }


            
            
            
            
            
        }.padding(20)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8563061953, green: 0.9900180697, blue: 0.8731382489, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                    .blur(radius: 2)
                    .padding(2)
                .shadow(radius: 20)
                
        )
    }
    
    func getProject(projectName: String) -> Project {
        for project in projectsViewModel.projects {
            if project.name == projectName {
                return project
            }
            
        }
        print("Error: Can't find that project")
        return projectData[0]
        
    }
    
    func loadImageFromStorage() {
        let storage = Storage.storage().reference()
        let imageRef = storage.child("images/AAA.jpg")
        imageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            self.url = "\(url!)"

        }

    }
}




struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard(profile: profileData[0])
    }
}
