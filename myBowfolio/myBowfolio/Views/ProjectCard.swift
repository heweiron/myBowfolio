//
//  ProjectCard.swift
//  myBowfolio
//
//  Created by weirong he on 8/30/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage


struct ProjectCard: View {
    
    var project: Project
    //@State var url: String = ""
    @ObservedObject private var viewModel = ProfilesViewModel()

    var body: some View {
        
        VStack(spacing: 20) {
            
            // Title and Image
            HStack {
                
                if project.picture != "" {
                    WebImage(url: URL(string: project.picture)).resizable().frame(width: 80, height: 80).cornerRadius(50)
                } else {
                    Loader()
                }
                Text("\(project.name)").fontWeight(.bold)
                Spacer()
            }
            
            // description
            Text("\(project.description)").font(.subheadline).foregroundColor(Color.black).fixedSize(horizontal: false, vertical: true)
            Divider()
            
            // interests
            
            // make interests scrollable so that they can poresent in the the fix height
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(project.interests, id: \.self) {interest in
                        Text("  \(interest)  ")
                            .fontWeight(.semibold)
                            .background(Color(#colorLiteral(red: 0.4322651923, green: 0.5675497651, blue: 0.8860189915, alpha: 1)))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                        
                        
                    }
                }
            }
            
            // participants
            
            Divider()
            ScrollView(.horizontal) {
                HStack{
                    ForEach(getParticipants(project: project.name) , id: \.self) { participant in
                        WebImage(url: URL(string: participant)).resizable().frame(width: 50, height: 50).cornerRadius(50)
                        
                    }
                }
            }.onAppear() {
                self.viewModel.fetchData()
            }
            
            
            
            
            
        }.padding(20)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8491371274, green: 0.9115262032, blue: 0.9936997294, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                    .blur(radius: 2)
                    .padding(2)
                .shadow(radius: 20)
                
        )
       // .onAppear(perform: loadImageFromStorage)
    }
    

    // filter the profileData to get profiles that in the given project
    func getParticipants(project: String) -> [String] {
        
        var participants: [String] = []
        for profile in viewModel.profiles {
            if profile.projects.contains(project) {

                participants.append(profile.picture)
            }
        }
        return participants
    }
    
//    func loadImageFromStorage() {
//        let storage = Storage.storage().reference()
//        let imageRef = storage.child("images/\(project.name).jpg")
//        imageRef.downloadURL { (url, error) in
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//            self.url = "\(url!)"
//
//
//        }
//
//    }
    
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(project: projectData[0])
    }
}

