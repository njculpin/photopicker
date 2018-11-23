//
//  InstagramPhotosViewController.swift
//  photopicker
//
//  Created by Nicholas Culpin on 11/23/18.
//  Copyright © 2018 Nicholas Culpin. All rights reserved.
//

import UIKit

class InstagramPhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var images = [
        "https://media-cdn.tripadvisor.com/media/photo-m/1280/01/70/71/51/the-painted-ladies-of.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-m/1280/01/70/71/51/the-painted-ladies-of.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-m/1280/01/70/71/51/the-painted-ladies-of.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-m/1280/01/70/71/51/the-painted-ladies-of.jpg",
        ]
    
    var cellId = "listCell"
    
    lazy var imagesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.decelerationRate = UIScrollView.DecelerationRate.fast
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    

    func setupViews(){
        self.view.addSubview(imagesCollectionView)
        imagesCollectionView.fillSuperview()
        imagesCollectionView.reloadData()
        imagesCollectionView.allowsMultipleSelection = false
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(InstagramPhotosCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InstagramPhotosCollectionViewCell
        let foundImage = images[indexPath.row]
        Cell.image = foundImage
        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        let filterView = FilterViewController()
        filterView.instagramImage = image
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = ((imagesCollectionView.bounds.size.width - 44) / CGFloat(3.0)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
