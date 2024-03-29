//
//  Int+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import Foundation

extension Int {
    var divided255: CGFloat {
        return CGFloat(self) / 255
    }
    
    private static let numberFormatter = NumberFormatter()
    
    // 숫자 포맷: 세자리수 콤마
    func setComma() -> String {
        Int.numberFormatter.numberStyle = .decimal
        return Int.numberFormatter.string(for: self) ?? "0"
    }
}
