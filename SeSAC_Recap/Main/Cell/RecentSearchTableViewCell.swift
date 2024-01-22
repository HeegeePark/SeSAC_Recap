//
//  RecentSearchTableViewCell.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    @IBOutlet var magnifierImageView: UIImageView!
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cofigureUI()
    }
}

extension RecentSearchTableViewCell {
    func cofigureUI() {
        magnifierImageView.image = UIImage(systemName: SFSymbol.magnifyingglass)
        magnifierImageView.tintColor = .white
        
        searchLabel.font = .sf13
        searchLabel.textColor = .text
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .light)
        let image = UIImage(systemName: SFSymbol.xmark, withConfiguration: imageConfig)
        deleteButton.setImage(image, for: .normal)
        deleteButton.tintColor = .white
    }
    
    func bindItem(log: SearchLog) {
        searchLabel.text = log.keyword
    }
}
