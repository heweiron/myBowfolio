//
//  EditProject.swift
//  myBowfolio
//
//  Created by weirong he on 9/5/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct EditProject: View {

    
    var body: some View {
        VStack {
            Button(action: {
                var string = " abc abc  "
                string = string.trimmingCharacters(in: .whitespacesAndNewlines)
                print(string)
            }) {
                Text("Add")
            }

            
        }
    }
}

struct EditProject_Previews: PreviewProvider {
    static var previews: some View {
        EditProject()
    }
}
