//
//  ProfileImageCollectionViewCell.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        configureImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.setCornerRadius(style: .circle(contentView))
    }
    
    func configureImage() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 5
    }
    
    func updateImage(image: UIImage) {
        imageView.image = image
        imageView.layer.borderColor = isSelected ? UIColor.point.cgColor: UIColor.clear.cgColor
    }
}
