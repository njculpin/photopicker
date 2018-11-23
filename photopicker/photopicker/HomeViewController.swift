//
//  HomeViewController.swift
//  photopicker
//
//  Created by Nicholas Culpin on 11/23/18.
//  Copyright © 2018 Nicholas Culpin. All rights reserved.
//

import UIKit
import Photos

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    lazy var selectedImage: UIImageView = {
        let si = UIImageView()
        si.layer.masksToBounds = true
        si.contentMode = .scaleAspectFill
        si.translatesAutoresizingMaskIntoConstraints = false
        return si
    }()
    
    lazy var selectImageButton: UIButton = {
        let sb = UIButton()
        sb.setTitle("Pick", for: .normal)
        sb.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        self.view.addSubview(selectedImage)
        self.view.addSubview(selectImageButton)
        
        selectedImage.fillSuperview()
        selectImageButton.anchor(nil, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 22, bottomConstant: 22, rightConstant: 22, widthConstant: 0, heightConstant: 44)
    }
    
    @objc func pickImage(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        dismiss(animated: true) {
            self.selectedImage.image = self.filterImage(input: newImage)
        }
    }
    
    func filterImage(input:UIImage) -> UIImage{
        let inputCIImage = CIImage(image: input)!
        let filter = CIFilter(name: "CICrystallize")!
        filter.setValue(inputCIImage, forKey: kCIInputImageKey)
        filter.setValue(400, forKey: kCIInputRadiusKey)
        let outputImage = filter.outputImage!
        return UIImage(ciImage: outputImage)
    }
    
}
