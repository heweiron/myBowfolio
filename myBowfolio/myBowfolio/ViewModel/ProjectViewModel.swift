//
//  ProjectViewModel.swift
//  myBowfolio
//
//  Created by weirong he on 9/2/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import Firebase

class ProjectViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    @Published var project: Project = Project(name: "", homepage: "", description: "", interests: [])
    
    func addProject(project: Project) {
        do {
            let _ = try db.collection("projects").addDocument(from: project)
        } catch {
            print(error)
        }
    }
}
