//
//  HomeViewController.swift
//  photopicker
//
//  Created by Nicholas Culpin on 11/23/18.
//  Copyright © 2018 Nicholas Culpin. All rights reserved.
//

import UIKit
import Photos

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var colors = 4
    let filterNames = CIFilter.filterNames(inCategories: nil)

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
    
    var colorCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.decelerationRate = UIScrollView.DecelerationRate.fast
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        self.view.addSubview(selectedImage)
        self.view.addSubview(selectImageButton)
//        self.view.addSubview(colorCollectionView)
        
        selectedImage.fillSuperview()
        selectImageButton.anchor(nil, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 22, bottomConstant: 22, rightConstant: 22, widthConstant: 0, heightConstant: 44)
//        colorCollectionView.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 44, leftConstant: 44, bottomConstant: 44, rightConstant: 44, widthConstant: 0, heightConstant: 0)
//
//
//        colorCollectionView.delegate = self
//        colorCollectionView.dataSource = self
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
        filter.setValue(55, forKey: kCIInputRadiusKey)
        let outputImage = filter.outputImage!
        return UIImage(ciImage: outputImage)
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return colors
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = UICollectionViewCell()
//        cell.backgroundColor = .red
//        return cell
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: colorCollectionView.bounds.size.width, height: colorCollectionView.bounds.size.height)
//    }
    
}
