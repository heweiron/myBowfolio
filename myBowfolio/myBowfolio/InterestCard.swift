//
//  InterestCard.swift
//  myBowfolio
//
//  Created by weirong he on 8/30/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct InterestCard: View {
    
    @ObservedObject private var profilesViewModel = ProfilesViewModel()
    @ObservedObject private var projectsViewModel = ProjectsViewModel()
    
    var interest: String
    var body: some View {
        VStack(spacing: 20) {
            
            // interest name
            Text(interest).fontWeight(.semibold)
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(getProfilesAndProjects(interest: interest), id: \.self) { profileOrProject in
                        Text(profileOrProject)
                    }
                }
            }.onAppear() {
                self.profilesViewModel.fetchData()
                self.projectsViewModel.fetchData()
            }
            
        }.padding(20)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8530271649, blue: 0.8504630923, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                    .blur(radius: 2)
                    .padding(2)
                    .shadow(radius: 20, x: 20, y: 20)
                
        )
        
    }
    
    func getProfilesAndProjects(interest: String) -> [String] {
        var result: [String] = []
        self.profilesViewModel.fetchData()
        self.projectsViewModel.fetchData()
        
        // search in profileData
        for profile in profilesViewModel.profiles {

            if profile.interests.contains(interest) {
                
                // TODO: change firstName to Image
                result.append(profile.firstName)

            }
        }
        
        // search in projectData
        for project in projectsViewModel.projects {
            if project.interests.contains(interest) {
                // TODO: change .name to Image
                result.append(project.name)
            }
        }
        
        if result.count <= 0 {
            print("empty")
        }
        
        return result
    }
}

struct InterestCard_Previews: PreviewProvider {
    static var previews: some View {
        InterestCard(interest: interests[0])
    }
}


