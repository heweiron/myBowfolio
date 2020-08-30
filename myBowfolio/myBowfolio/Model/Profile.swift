//
//  Profile.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import SwiftUI

struct Profile: Codable {
    
    var firstName: String
    var lastName: String
    var email: String
    var bio: String
    var title: String
    var projects: [String]
}
