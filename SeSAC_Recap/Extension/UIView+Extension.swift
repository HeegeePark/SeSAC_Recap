//
//  UIView+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UIView {
    func setCornerRadius(style: CornerRoundStyle = .default) {
        self.layer.cornerRadius = style.cornerRadius
        self.layer.masksToBounds = true
    }
    
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
}

enum CornerRoundStyle {
    case `default`
    case small
    case medium
    case large
    case circle(UIView)
    
    var cornerRadius: CGFloat {
        switch self {
        case .default:
            return 10
        case .small:
            return 8
        case .medium:
            return 16
        case .large:
            return 20
        case .circle(let view):
            return view.frame.width / 2
        }
    }
}

