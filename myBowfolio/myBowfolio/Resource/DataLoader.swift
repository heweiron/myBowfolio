//
//  DataLoader.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import Foundation
import UIKit

public class DataLoader {
    
    @Published var userData = [UserData]()
    
    init() {
        load()
    }
    
    func load() {
        
        if let fileLoaction = Bundle.main.url(forResource: "Profiles", withExtension: "json") {
            
            do {
            let data = try Data(contentsOf: fileLoaction)
            let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([UserData].self, from: data)
                self.userData = dataFromJson
                print(userData)
            } catch {
                print(error)
            }
            
        }
    }
    
}
