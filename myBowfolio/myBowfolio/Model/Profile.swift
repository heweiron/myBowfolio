//
//  Profile.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct Profile: Codable, Hashable {
    
    @DocumentID var id: String? = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var bio: String
    var title: String
    var projects: [String]
    var interests: [String]
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case bio
        case title
        case projects
        case interests
    }
}
