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
    @Binding var imageName: String
    
    
    
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
            let image = info[.originalImage] as! UIImage
            let storage = Storage.storage()
            storage.reference().child(parent.imageName).putData(image.jpegData(compressionQuality: 0.35)!, metadata: nil) { (_, error) in
                
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                print("Success")
            }
            parent.show.toggle()
        }
    }
    

    
}

