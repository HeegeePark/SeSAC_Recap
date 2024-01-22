//
//  MainViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // TabBar height
    var tabBarHeight: CGFloat {
        return self.tabBarController!.tabBar.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showToast()
        configureView()
        configureNavigationBar()
        configureTableView()
    }
    
    func showToast() {
        DeviceUtils.tabBarHeight = tabBarHeight
        showToast(message: "\(UserDefaultUtils.user.nickname)님, 환영합니다. 🌱", font: .sf15)
    }

}

// MARK: Custom UI
extension MainViewController {
    override func configureView() {
        super.configureView()
        
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        navigationItem.title = "\(UserDefaultUtils.user.nickname)님의 새싹쇼핑"
    }
}
