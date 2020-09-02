//
//  ProjectsViewModel.swift
//  myBowfolio
//
//  Created by weirong he on 9/1/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
 
class ProjectsViewModel: ObservableObject {
    @Published var projects = [Project]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("projects").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.projects = documents.compactMap { (queryDocumentSnapshot) -> Project? in
               return try? queryDocumentSnapshot.data(as: Project.self)

            }
            
        }
    }
}
