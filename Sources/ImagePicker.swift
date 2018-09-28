//
//  ImagePicker.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 26/12/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

public class ImagePicker {
    public var imageHandler: ((UIImage) -> Void)?
    weak var controller: UIViewController?
    weak var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    
    public init(controller: UIViewController?) {
        self.controller = controller
        if let delegate = controller as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
            self.delegate = delegate
        }
    }
    
    public func promptSelectImage(completion: ((UIImage) -> Void)? = nil) {
        imageHandler = completion
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Desde la galería".localized, style: .default, handler: { _ in
            self.requestImage(from: .savedPhotosAlbum)
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Desde la cámara".localized, style: .default, handler: { _ in
                self.requestImage(from: .camera)
                
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancelar".localized, style: .cancel, handler: nil))
        controller?.present(alert, animated: true, completion: nil)
    }
    
    public func requestImage(from sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = delegate
        picker.allowsEditing = true
        picker.sourceType = sourceType
        controller?.present(picker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        controller?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageHandler?(image)
            imageHandler = nil
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        controller?.dismiss(animated: true, completion: nil)
    }
}
