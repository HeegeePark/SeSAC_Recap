//
//  UIImage+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UIImage {
    enum Profile {
        static let range = 0..<14
        
        static subscript(idx: Int) -> UIImage {
            return UIImage(named: "profile\(idx + 1)")!
        }
        
        static var list: [UIImage] {
            return range.map { Profile[$0] }
        }
    }
}
