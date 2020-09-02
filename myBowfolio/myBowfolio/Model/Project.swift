//
//  Project.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Project: Codable, Hashable, Identifiable {
    
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var homepage: String
    var description: String
    var interests: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case homepage
        case description
        case interests
    }
}
