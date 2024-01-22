//
//  MainViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableViewArea: UIView!
    @IBOutlet var recentSearchLabel: UILabel!
    @IBOutlet var clearRecentSearchButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var emptyView: UIView!
    @IBOutlet var emptyImageView: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showToast()
        configureView()
        configureNavigationBar()
        configureTableView()
    }
    
    func showToast() {
        DeviceUtils.tabBarHeight = tabBarController!.tabBar.frame.size.height
        showToast(message: "\(UserDefaultUtils.user.nickname)님, 환영합니다. 🌱", font: .sf15)
    }

}

// MARK: Custom UI
extension MainViewController {
    override func configureView() {
        super.configureView()
        
        tableViewArea.isHidden = true
        
        // 서치바
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        // 테이블뷰 area
        tableViewArea.backgroundColor = view.backgroundColor
        
        // 최근 검색 레이블
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.font = .sf14Bold
        recentSearchLabel.textColor = .text
        
        // 모두 지우기 버튼
        clearRecentSearchButton.setTitle("모두 지우기", for: .normal)
        clearRecentSearchButton.titleLabel?.font = .sf13Bold
        clearRecentSearchButton.setTitleColor(.point, for: .normal)
        
        // 최근 검색어 nil 뷰
        emptyView.backgroundColor = .clear
        
        // 최근 검색어 nil 이미지 뷰
        emptyImageView.image = .empty
        emptyImageView.contentMode = .scaleAspectFit
        
        // 최근 검색어 nil 레이블
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.font = .sf16Bold
        emptyLabel.textColor = .text
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        navigationItem.title = "\(UserDefaultUtils.user.nickname)님의 새싹쇼핑"
    }
    
    override func configureTableView() {
        super.configureTableView()
        
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
    }
}

// MARK: - Preview

import SwiftUI
struct PreView: PreviewProvider {
    static var previews: some View {
        let vc = UIStoryboard(name: StoryboardId.main, bundle: nil)
            .instantiateViewController(withIdentifier: MainViewController.identifier)
        vc.toPreview()
    }
}
