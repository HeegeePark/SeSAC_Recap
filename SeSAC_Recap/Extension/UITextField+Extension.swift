//
//  UITextField+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UITextField {
    func setPlaceholder(_ placeholder: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [.foregroundColor: color]
        )
    }
    
    func setLeftView(inset: CGFloat) {
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftView = leftPadding
        self.leftViewMode = .always
    }
}
