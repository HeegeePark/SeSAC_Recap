//
//  UILabel+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/24/24.
//

import UIKit

extension UILabel {
    // 특정 키워드 글자색 변경
    func changeForegroundColor(keyword: String, color: UIColor) {
        guard let text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        
        let range = (text as NSString).range(of: keyword)
        
        attributedString.addAttribute(.foregroundColor, value: color,
                                      range: range)
        
        self.attributedText = attributedString
    }
}


