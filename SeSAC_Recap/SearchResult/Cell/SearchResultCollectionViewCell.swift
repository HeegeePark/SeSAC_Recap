//
//  SearchResultCollectionViewCell.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit
import Kingfisher

// TODO: 제품명 2줄 나오게 처리

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    
    @IBOutlet var mallNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var lPriceLabel: UILabel!
    
    @IBOutlet var wishButton: UIButton!
    var wishButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .light)
    
    var isWished: Bool = false {
        didSet {
            let imageStr = !isWished ? SFSymbol.heart: SFSymbol.heartFill
            let image = UIImage(systemName: imageStr, withConfiguration: wishButtonImageConfig)
            wishButton.setImage(image, for: .normal)
        }
    }
    
    var wishedHandler: ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    @objc func wishButtonTapped(_ sender: UIButton) {
        isWished.toggle()
        wishedHandler?(isWished)
    }
}

extension SearchResultCollectionViewCell {
    func configureUI() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.setCornerRadius(style: .medium)
        
        mallNameLabel.font = .sf13
        mallNameLabel.textColor = .text
        
        titleLabel.font = .sf14
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        lPriceLabel.font = .sf15Bold
        lPriceLabel.textColor = .text
        
        let image = UIImage(systemName: SFSymbol.heart, withConfiguration: wishButtonImageConfig)
        wishButton.setImage(image, for: .normal)
        wishButton.tintColor = .black
        wishButton.backgroundColor = .white
        wishButton.layer.cornerRadius = 15
        wishButton.addTarget(self, action: #selector(wishButtonTapped), for: .touchUpInside)
    }
    
    func bindItem(item: Item) {
        let itemInfo = ItemInfo(item: item)
        
        thumbnailImageView.kf.setImage(with: itemInfo.thumbnailImageURL)
        
        mallNameLabel.text = item.mallName
        titleLabel.text = itemInfo.title
        lPriceLabel.text = itemInfo.lPrice
        
        isWished = itemInfo.isWished
    }
}
