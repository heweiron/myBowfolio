//
//  Test.swift
//  myBowfolio
//
//  Created by weirong he on 9/4/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import FirebaseUI

struct Test: View {
    // Reference to an image file in Firebase Storage
    let storageRef = Storage.storage().reference()
    var imageView = UIImageView()

    var body: some View {
        
        VStack {
            Button(action: {
                // Reference to an image file in Firebase Storage
                let reference = self.storageRef.child("images/stars.jpg")

                // UIImageView in your ViewController
                let imageView: UIImageView = self.imageView

                // Placeholder image
                let placeholderImage = UIImage(named: "placeholder.jpg")

                // Load the image using SDWebImage
                imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
            }) {
                Text("Button")
            }
\
            
            
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
