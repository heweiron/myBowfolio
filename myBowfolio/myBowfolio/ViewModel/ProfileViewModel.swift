//
//  ProfileViewModel.swift
//  myBowfolio
//
//  Created by weirong he on 9/4/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import Firebase
import Combine

class ProfileViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var profile: Profile
    @Published var modified = false
    
    init(profile: Profile  = Profile(firstName: "", lastName: "", email: "", bio: "", title: "", projects: [], interests: [])) {
        self.profile = profile
        
        self.$profile
            .dropFirst()
            .sink { [weak self] project in
                self?.modified = true
        }
    .store(in: &cancellables)
    }
    
    func addProfile(profile: Profile) {
        do {
            let _ = try db.collection("profiles").document(profile.email).setData(from: profile)
            print("added")
        } catch {
            print(error)
        }
    }
    
    func save() {
        addProfile(profile: profile)
    }
    
    
    
    
}
