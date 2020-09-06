//
//  ProfileCard.swift
//  myBowfolio
//
//  Created by weirong he on 8/30/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCard: View {
    
    var profile: Profile
    @ObservedObject var projectsViewModel = ProjectsViewModel()


    var body: some View {
        
        VStack(spacing: 20) {
            
            HStack {

                if profile.picture != "" {
                    WebImage(url: URL(string: profile.picture)).resizable().frame(width: 80, height: 80).cornerRadius(15)
                } else {
                    Image("default").resizable().frame(width: 80, height: 80)
                }
                
                VStack(spacing: 20) {
                    // Title
                    Text("\(profile.firstName) \(profile.lastName)").fontWeight(.bold)
                    Text(profile.title).foregroundColor(Color.black.opacity(0.6))
                }
                Spacer()
            }
            
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
                            AnimatedImage(url: URL(string: self.getProject(projectName: project))).resizable().frame(width: 50, height: 50).cornerRadius(50)
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
    
    func getProject(projectName: String) -> String {
        for project in projectsViewModel.projects {
            if project.name == projectName {
                return project.picture
            }
            
        }
        print("Error: Can't find that project")
        return ""
        
    }
//
//    func loadImageFromStorage() -> String {
//        let storage = Storage.storage().reference()
//        let imageRef = storage.child("images/AAA.jpg")
//        var temp: String = ""
//        imageRef.downloadURL { (url, error) in
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//            temp = "\(url!)"
//
//        }
//        return temp
//    }
}




struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard(profile: profileData[3])
    }
}
