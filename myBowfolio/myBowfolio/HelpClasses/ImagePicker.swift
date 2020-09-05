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
    //@Binding var imageName: String
    @Binding var image: UIImage?
    
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->
        UIImagePickerController {
        
            let imagepic = UIImagePickerController()
            imagepic.sourceType = .photoLibrary
            imagepic.delegate = context.coordinator
            return imagepic
            
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
           
       }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(parent1: self)
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
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.show.toggle()
        }
    }
    

    
}

