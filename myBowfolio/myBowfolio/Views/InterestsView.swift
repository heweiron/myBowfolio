//
//  InterestsView.swift
//  myBowfolio
//
//  Created by weirong he on 8/31/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct InterestsView: View {
    
    @ObservedObject private var profilesViewModel = ProfilesViewModel()
    @ObservedObject private var projectsViewModel = ProjectsViewModel()
    
    var body: some View {

            VStack {
                
                List(interests, id: \.self) { interest in
                    InterestCard(interest: interest).padding(.bottom, 40)
                }.id(UUID())
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        .onAppear() {
            self.profilesViewModel.fetchData()
            self.projectsViewModel.fetchData()
        }
    }
    
    func getInterests() -> [String] {
        var interestsArray: [String] = []
        for profile in profilesViewModel.profiles {
            for interest in profile.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }
        
        for project in projectsViewModel.projects {
            for interest in project.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }
        return interestsArray

        
    }
    
}

struct InterestsView_Previews: PreviewProvider {
    static var previews: some View {
        InterestsView()
    }
}





