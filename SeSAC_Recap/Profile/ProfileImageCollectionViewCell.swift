//
//  ProfileImageCollectionViewCell.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.setCornerRadius(style: .circle(contentView))
    }
    
    func configureImage(image: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFill        
    }
    
    func selectImage() {
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.point.cgColor
    }
}
