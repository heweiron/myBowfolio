//
//  Data.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation

struct UserData: Codable {
    var defaultPrifiles: [ProfilesData]
    var defaultProjects: [ProjectData]
}
