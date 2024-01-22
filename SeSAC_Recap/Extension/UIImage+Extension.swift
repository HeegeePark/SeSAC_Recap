//
//  UIImage+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UIImage {
    enum Profile {
        static let range = 1...14
        
        static subscript(idx: Int) -> UIImage {
            return UIImage(named: "profile\(idx)")!
        }
        
        static var list: [UIImage] {
            return range.map { Profile[$0] }
        }
    }
}
