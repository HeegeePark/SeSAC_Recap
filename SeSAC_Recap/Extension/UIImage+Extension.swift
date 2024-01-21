//
//  UIImage+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UIImage {
    static var randomProfile: UIImage {
        let idx = Int.random(in: 1...14)
        return UIImage(named: "profile\(idx)")!
    }
}
