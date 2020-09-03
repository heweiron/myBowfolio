//
//  ProjectViewModel.swift
//  myBowfolio
//
//  Created by weirong he on 9/2/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import Firebase
import Combine

class ProjectViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var project: Project
    @Published var modified = false
    
    init(project: Project  = Project(name: "", homepage: "", description: "", interests: [])) {
        self.project = project
        
        self.$project
            .dropFirst()
            .sink { [weak self] project in
                self?.modified = true
        }
    .store(in: &cancellables)
    }
    
    func addProject(project: Project) {
        do {
            let _ = try db.collection("projects").addDocument(from: project)
        } catch {
            print(error)
        }
    }
    
    func save() {
        addProject(project: project)
    }
}
