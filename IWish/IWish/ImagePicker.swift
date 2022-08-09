//
//  PhotoPicker.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 8/3/22.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
//    @Environment(\.presentationMode) private var presentationMode
//    var selectedItem: Item
//    @Binding var selectedImage: UIImage
//
//
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//
//    func makeUIViewController(context:UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = sourceType
//        imagePicker.delegate = context.coordinator
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//        var parent: ImagePicker
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                parent.selectedImage = image
//                ImageStorage.shared.saveImageToDocumentDirectory(image: image, name: parent.selectedItem.itemName)
//            }
//           parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
    @Binding var image: UIImage?
    private let controller = UIImagePickerController()
    
       func makeCoordinator() -> Coordinator {
           return Coordinator(parent: self)
       }
    
       class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
           let parent: ImagePicker
    
           init(parent: ImagePicker) {
               self.parent = parent
           }
    
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               parent.image = info[.originalImage] as? UIImage
               picker.dismiss(animated: true)
           }
    
           func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
               picker.dismiss(animated: true)
           }
    
       }
    
       func makeUIViewController(context: Context) -> some UIViewController {
           controller.delegate = context.coordinator
           return controller
       }
    
       func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
       }
}
