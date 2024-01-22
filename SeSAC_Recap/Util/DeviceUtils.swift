//
//  DeviceUtils.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

enum DeviceUtils {
    // window
    static var window: UIWindow? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        return sceneDelegate?.window
    }
    
    // 디바이스 width
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // 디바이스 height
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // TabBar height
    static var tabBarHeight: CGFloat = 80
}
