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
    
    lazy var colorOne: UIView = {
        let image = UIView()
        image.heightAnchor.constraint(equalToConstant: 66).isActive = true
        image.widthAnchor.constraint(equalToConstant: 66).isActive = true
        return image
    }()

    lazy var colorTwo: UIView = {
        let image = UIView()
        image.heightAnchor.constraint(equalToConstant: 66).isActive = true
        image.widthAnchor.constraint(equalToConstant: 66).isActive = true
        return image
    }()
    
    lazy var colorThree: UIView = {
        let image = UIView()
        image.heightAnchor.constraint(equalToConstant: 66).isActive = true
        image.widthAnchor.constraint(equalToConstant: 66).isActive = true
        return image
    }()
    
    lazy var colorFour: UIView = {
        let image = UIView()
        image.heightAnchor.constraint(equalToConstant: 66).isActive = true
        image.widthAnchor.constraint(equalToConstant: 66).isActive = true
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 16.0
        sv.axis = .vertical
        sv.alignment = .center
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        self.view.addSubview(selectedImage)
        self.view.addSubview(selectImageButton)
        self.view.addSubview(stackView)
        
        selectedImage.fillSuperview()
        selectImageButton.anchor(nil, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 22, bottomConstant: 22, rightConstant: 22, widthConstant: 0, heightConstant: 44)
        stackView.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 22, leftConstant: 22, bottomConstant: 0, rightConstant: 0, widthConstant: 66, heightConstant: 0)
        
        stackView.addArrangedSubview(colorOne)
        stackView.addArrangedSubview(colorTwo)
        stackView.addArrangedSubview(colorThree)
        stackView.addArrangedSubview(colorFour)
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
            self.selectedImage.image = newImage
            let filteredImage = self.filterImage(input: newImage)
            filteredImage.getColors(quality: .high) { colors in
                UIView.animate(withDuration: 0.15, animations: {
                    self.colorOne.backgroundColor = colors.primary
                    self.colorTwo.backgroundColor = colors.secondary
                    self.colorThree.backgroundColor = colors.detail
                    self.colorFour.backgroundColor = colors.background
                })
            }
        }
    }
    
    func filterImage(input:UIImage) -> UIImage{
        let inputCIImage = CIImage(image: input)!
        let filter = CIFilter(name: "CICrystallize")!
        filter.setValue(inputCIImage, forKey: kCIInputImageKey)
        filter.setValue(100, forKey: kCIInputRadiusKey)
        let outputImage = filter.outputImage!
        return UIImage(ciImage: outputImage)
    }
    
}
