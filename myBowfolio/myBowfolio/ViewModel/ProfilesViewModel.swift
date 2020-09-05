//
//  ProfileViewModel.swift
//  myBowfolio
//
//  Created by weirong he on 9/1/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
 
class ProfilesViewModel: ObservableObject {
    @Published var profiles = [Profile]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("profiles").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.profiles = documents.compactMap { (queryDocumentSnapshot) -> Profile? in
               return try? queryDocumentSnapshot.data(as: Profile.self)

            }
            
        }
    }
    
    
    func addOneProject(projectName: String, email: String) {
        db.collection("profiles").document(email.lowercased()).updateData(["projects" : FieldValue.arrayUnion([projectName])])
        
        print("updated!")
        
        }
}
