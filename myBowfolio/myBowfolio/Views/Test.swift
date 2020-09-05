//
//  Test.swift
//  myBowfolio
//
//  Created by weirong he on 9/4/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseStorage


struct Test: View {
    
    @State var url = ""
    @State var isSuccess = false
    
    
    var body: some View {
        
        VStack {
            Button(action: {
                print(self.url)
            }) {
                Text("Button")
            }
            if url != "" {
//                WebImage(url: URL(string: url)).resizable().aspectRatio(contentMode: .fit)
                Text(url)
            } else {
                Loader()
            }
        }.onAppear() {
            self.loadImageFromStorage()
        }

    }
    
    func loadImageFromStorage() {
        let storage = Storage.storage().reference()
        let imageRef = storage.child("images/AAA.jpg")
        imageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            self.url = "\(url!)"
            

        }

    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
