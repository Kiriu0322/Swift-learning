//
//  ImagePickerView.swift
//  CameraApp
//
//  Created by Kiriu Tomoki on 2024/09/18.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var isShowSheet: Bool
    @Binding var captureImage: UIImage?

    class Coordinator: NSObject , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true){
                if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    self.parent.captureImage = originalImage
                }
            }
//            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                parent.captureImage = originalImage
//            }
//            parent.isShowSheet.toggle()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet.toggle()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let myImagePickerController = UIImagePickerController()
        myImagePickerController.sourceType = .camera
        myImagePickerController.delegate = context.coordinator
        return myImagePickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
}
