//
//  User.swift
//  myBowfolio
//
//  Created by weirong he on 9/3/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Codable, Hashable, Identifiable {
    
    @DocumentID var id: String? = UUID().uuidString
    var email: String
    var displayName: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case displayName
        case id

    }
}
