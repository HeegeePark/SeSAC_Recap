//
//  ProfileType.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/23/24.
//

import UIKit

enum ProfileType {
    case onboarding(randomProfileIndex: Int)
    case setting(currentProfileIndex: Int)
    
    var image: UIImage {
        switch self {
        case .onboarding(let randomProfileIndex):
            return UIImage.Profile[randomProfileIndex]
        case .setting(let currentProfileIndex):
            return UIImage.Profile[currentProfileIndex]
        }
    }
}
