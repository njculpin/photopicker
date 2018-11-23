//
//  InstagramPhotosCollectionViewCell.swift
//  photopicker
//
//  Created by Nicholas Culpin on 11/23/18.
//  Copyright © 2018 Nicholas Culpin. All rights reserved.
//

import UIKit

class InstagramPhotosCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        contentView.widthAnchor.constraint(equalToConstant: screenWidth - ( 3 * 12 )).isActive = true
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var image: String! {
        didSet {
            imageView.dowloadFromServer(link: image!)
            self.setNeedsLayout()
        }
    }
    
}



