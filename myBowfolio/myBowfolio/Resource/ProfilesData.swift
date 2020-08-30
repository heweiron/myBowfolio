//
//  ProfilesData.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct ProfilesData: Codable {
    var firstName: String
    var lastName: String
    var bio: String
    var title: String
    var interests: [String]
    var projects: [String]
    var picture: String
    var email: String
}
