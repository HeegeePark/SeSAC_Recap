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
        connetHandler()
    }
    
    func showToast() {
        DeviceUtils.tabBarHeight = tabBarController!.tabBar.frame.size.height
        showToast(message: "\(UserDefaultUtils.user.nickname)님, 환영합니다. 🌱", font: .sf15)
    }
    
    func connetHandler() {
        UserDefaultUtils.searchLogsHadler = {
            self.tableViewArea.isHidden = UserDefaultUtils.searchLogs.isEmpty
            self.tableView.reloadData()
        }
    }
    
    @objc func clearRecentSearchButtonTapped(_ sender: UIButton) {
        UserDefaultUtils.searchLogs.removeAll()
    }
}

// MARK: Custom UI
extension MainViewController: UITableViewControllerProtocol {
    override func configureView() {
        super.configureView()
        
        // 서치바
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.delegate = self
        
        // 테이블뷰 area
        tableViewArea.backgroundColor = view.backgroundColor
        tableViewArea.isHidden = UserDefaultUtils.searchLogs.isEmpty
        
        // 최근 검색 레이블
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.font = .sf14Bold
        recentSearchLabel.textColor = .text
        
        // 모두 지우기 버튼
        clearRecentSearchButton.setTitle("모두 지우기", for: .normal)
        clearRecentSearchButton.titleLabel?.font = .sf13Bold
        clearRecentSearchButton.setTitleColor(.point, for: .normal)
        clearRecentSearchButton.addTarget(self, action: #selector(clearRecentSearchButtonTapped), for: .touchUpInside)
        
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
    
    func configureTableView() {
        registerXib()
        connectDelegate()
        
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerXib() {
        let xib = UINib(nibName: RecentSearchTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
    }
    
    func connectDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultUtils.searchLogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as! RecentSearchTableViewCell
        
        let log = UserDefaultUtils.searchLogs.reversed()[indexPath.row]
                
        cell.bindItem(log: log)
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != "" else { return }
        
        // Userdefaults에 저장
        UserDefaultUtils.searchLogs.append(SearchLog(keyword: searchBar.text!))
        
        // TODO: 검색 키워드 가지고 검색 결과 화면 전환
    }
}
