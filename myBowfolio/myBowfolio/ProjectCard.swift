//
//  ProjectCard.swift
//  myBowfolio
//
//  Created by weirong he on 8/30/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct ProjectCard: View {
    
    var project: Project
    @ObservedObject private var viewModel = ProfilesViewModel()

    var body: some View {
        
        VStack(spacing: 20) {
            
            // Title
            Text("\(project.name)").fontWeight(.bold)
            
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
            
            // TODO: change String of name to the Image of Profile
            Divider()
            ScrollView(.horizontal) {
                HStack{
                    ForEach(getParticipants(project: project.name) , id: \.self) { participant in
                        Text(participant)
                        
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
    }
    

    // filter the profileData to get profiles that in the given project
    func getParticipants(project: String) -> [String] {
        
        var participants: [String] = []
        for profile in viewModel.profiles {
            if profile.projects.contains(project) {
                // TODO: should be profile.image, change it later
                participants.append(profile.firstName)
            }
        }
        return participants
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(project: projectData[0])
    }
}

