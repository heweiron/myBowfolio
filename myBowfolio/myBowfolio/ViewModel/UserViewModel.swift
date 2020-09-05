//
//  UserViewModel.swift
//  myBowfolio
//
//  Created by weirong he on 9/3/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import Firebase
import Combine

class UserViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var user: User
    @Published var modified = false
    
    init(user: User  = User(id: "", email: "", displayName: "")) {
        self.user = user
        
    }
    
    func addUser(user: User) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
        } catch {
            print(error)
        }
    }

}
