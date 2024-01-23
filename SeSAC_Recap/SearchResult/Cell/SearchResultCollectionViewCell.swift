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
    var isWished: Bool = false {
        didSet {
            wishedHandler?()
        }
    }
    
    var wishedHandler: (() -> Void)?
    
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
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .light)
        // TODO: 좋아요 여부 대응하기
        let image = UIImage(systemName: SFSymbol.heart, withConfiguration: imageConfig)
        wishButton.setImage(image, for: .normal)
        wishButton.tintColor = .black
        wishButton.backgroundColor = .white
        wishButton.layer.cornerRadius = 15
    }
    
    func bindItem(item: Item) {
        let url = URL(string: item.image)
        thumbnailImageView.kf.setImage(with: url)
        
        mallNameLabel.text = item.mallName
        titleLabel.text = item.title
        lPriceLabel.text = Int(item.lprice)!.setComma()
    }
}
