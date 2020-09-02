//
//  Data.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

//let landmarkData: [Landmark] = load("landmarkData.json")
let profileData: [Profile] = load("profiles.json")
let projectData: [Project] = load("projects.json")
var interests: [String] = getInterests()

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func getInterests() -> [String] {
    var interestsArray: [String] = []
    for profile in profileData {
        for interest in profile.interests {
            if interestsArray.contains(interest) == false {
                interestsArray.append(interest)
            }
        }
    }

    for project in projectData {
        for interest in project.interests {
            if interestsArray.contains(interest) == false {
                interestsArray.append(interest)
            }
        }
    }

    return interestsArray

}
