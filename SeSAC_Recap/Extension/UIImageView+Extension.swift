//
//  UIImageView+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/23/24.
//

import UIKit

extension UIImageView {
    func setProfileImageView(typeFromProfileEdit type: ProfileType) {
        self.image = type.image
        self.contentMode = .scaleAspectFill
        self.layer.borderColor = UIColor.point.cgColor
        self.layer.borderWidth = 5
        self.setCornerRadius(style: .circle(self))
    }
}
