//
//  UsersViewModel.swift
//  myBowfolio
//
//  Created by weirong he on 9/4/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
 
class UsersViewModel: ObservableObject {
    @Published var users = [User]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
               return try? queryDocumentSnapshot.data(as: User.self)

            }
            
        }
    }
}
