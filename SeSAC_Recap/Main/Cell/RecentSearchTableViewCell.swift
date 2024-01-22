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
    
    var deletedHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cofigureUI()
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        deletedHandler?()
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
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func bindItem(log: SearchLog) {
        searchLabel.text = log.keyword
    }
}
