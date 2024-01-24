//
//  ProfileType.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/23/24.
//

import UIKit

enum ProfileType {
    case onboarding
    case setting
    
    var profileImageIndex: Int {
        switch self {
        case .onboarding:
            return Int.random(in: UIImage.Profile.range)
        case .setting:
            return UserDefaultUtils.user.profileImageIndex
        }
    }
    
    var image: UIImage {
        return UIImage.Profile[profileImageIndex]
    }
    
    var navigationItemTitle: String {
        switch self {
        case .onboarding:
            return "프로필 설정"
        case .setting:
            return "프로필 수정"
        }
    }
    
    var nickname: String {
        switch self {
        case .onboarding:
            return ""
        case .setting:
            return UserDefaultUtils.user.nickname
        }
    }
}
