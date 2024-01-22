//
//  SearchResultCollectionViewCell.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    
    @IBOutlet var mallNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var lPriceLabel: UILabel!
    
    @IBOutlet var wishButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
}

extension SearchResultCollectionViewCell {
    func configureUI() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.setCornerRadius(style: .medium)
        
        mallNameLabel.font = .sf13
        mallNameLabel.textColor = .text
        
        titleLabel.font = .sf15Bold
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        lPriceLabel.font = .sf13
        lPriceLabel.textColor = .text
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .light)
        // TODO: 좋아요 여부 대응하기
        let image = UIImage(systemName: SFSymbol.heart, withConfiguration: imageConfig)
        wishButton.setImage(image, for: .normal)
        wishButton.tintColor = .black
        wishButton.backgroundColor = .white
        wishButton.layer.cornerRadius = 15
    }
    
    func bindItem() {
        
    }
}
