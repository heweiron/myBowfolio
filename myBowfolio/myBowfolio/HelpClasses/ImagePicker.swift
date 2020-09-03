//
//  ImagePicker.swift
//  myBowfolio
//
//  Created by weirong he on 9/2/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var show: Bool
    @Binding var data: Data
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->
        UIImagePickerController {
        
            let imagepic = UIImagePickerController()
            imagepic.sourceType = .photoLibrary
            return imagepic
            
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
           
       }
    
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker!
        init(parent1: ImagePicker) {
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            <#code#>
        }
    }
    

    
}

