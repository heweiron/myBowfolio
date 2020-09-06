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
    
    init(project: Project  = Project(name: "", homepage: "", description: "", interests: [], picture: "")) {
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
            let _ = try db.collection("projects").document(project.id!).setData(from: project)
        } catch {
            print(error)
        }
    }
    
    func save() {
        addProject(project: project)
        loadImageFromStorage()
    }
    
    
    func loadImageFromStorage() {
        let storage = Storage.storage().reference()
        let imageRef = storage.child("images/\(project.name).jpg")
        imageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                self.loadImageFromStorage()
            } else {
            //self.project.picture = "\(url!)"
            self.db.collection("projects").document(self.project.id!).updateData(["picture" : "\(url!)"])
            }
            

        }

    }
    
}
