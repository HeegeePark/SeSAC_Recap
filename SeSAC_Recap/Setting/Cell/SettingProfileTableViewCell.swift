//
//  SettingProfileTableViewCell.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/23/24.
//

import UIKit

class SettingProfileTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var wishDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.setCornerRadius(style: .circle(profileImageView))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        wishDescriptionLabel.text = ""
    }
    
    func configureUI() {
        profileImageView.setProfileImageView(typeFromProfileEdit: .setting)
        
        nicknameLabel.text = UserDefaultUtils.user.nickname
        nicknameLabel.font = .sf19Bold
        nicknameLabel.textColor = .text
        
        wishDescriptionLabel.text = "\(UserDefaultUtils.wishes.count)개의 상품을 좋아하고 있어요!"
        wishDescriptionLabel.font = .sf15Bold
        wishDescriptionLabel.textColor = .text
        wishDescriptionLabel.changeForegroundColor(keyword: "\(UserDefaultUtils.wishes.count)개의 상품", color: .point)
    }
    
    func updateProfile() {
        profileImageView.setProfileImageView(typeFromProfileEdit: .setting)
        nicknameLabel.text = UserDefaultUtils.user.nickname
        wishDescriptionLabel.text = "\(UserDefaultUtils.wishes.count)개의 상품을 좋아하고 있어요!"
        wishDescriptionLabel.changeForegroundColor(keyword: "\(UserDefaultUtils.wishes.count)개의 상품", color: .point)
    }
    
}
