//
//  ImagePicker.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 25/04/26.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable{
   
    
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}


class ImagePickerCoordinator: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let parent: ImagePicker
    
    init(parent: ImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            parent.selectedImage = image
        }
        parent.dismiss()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.dismiss()
    }
}
