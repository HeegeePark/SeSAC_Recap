//
//  MainViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    let tableViewArea = UIView()
    let recentSearchLabel = UILabel()
    let clearRecentSearchButton = UIButton()
    let tableView = UITableView()
    
    let emptyView = UIView()
    let emptyImageView = UIImageView()
    let emptyLabel = UILabel()
    
    let keyboardDismissView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notification 권한 요청
        NotificationManager.shared.setAuthorization()
        
        configureHierarchy()
        setupConstraints()
        configureView()
        configureNavigationBar()
        configureTableView()
        connetHandler()
        showToast()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 검색 후 돌아왔을 때 최근 검색어 테이블뷰 상단으로 올리기
        if !tableViewArea.isHidden  {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    func showToast() {
        DeviceUtils.tabBarHeight = tabBarController!.tabBar.frame.size.height
        showToast(message: "\(UserDefaultUtils.user.nickname)님, 환영합니다. 🌱", font: .sf15)
    }
    
    func connetHandler() {
        UserDefaultUtils.searchLogsHandler = {
            self.tableViewArea.isHidden = UserDefaultUtils.searchLogs.isEmpty
            self.tableView.reloadData()
        }
    }
    
    func search(log: SearchLog) {
        // 최근 검색어에 이미 존재할 때
        if UserDefaultUtils.keyOfsearchLogsSet.contains(log.keyword) {
            let index = UserDefaultUtils.searchLogs.firstIndex(where: {$0.keyword == log.keyword})!
            UserDefaultUtils.searchLogs.remove(at: index)
        }
        
        // append
        UserDefaultUtils.searchLogs.append(log)
        
        // 화면 전환
        pushToSearchResultViewController(log: log)
        
    }
    
    // 검색 키워드를 가지고 검색 결과 화면 전환
    func pushToSearchResultViewController(log: SearchLog) {
        let vc = loadViewController(storyboardToPushIdentifier: StoryboardId.searchResult, viewControllerToChange: SearchResultViewController.self)
        vc.updateKeyword(log: log)
        
        // 서치바 text clear
        searchBar.text = ""
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clearRecentSearchButtonTapped(_ sender: UIButton) {
        UserDefaultUtils.searchLogs.removeAll()
    }
}

// MARK: Custom UI
extension MainViewController: UITableViewControllerProtocol {
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubviews(searchBar, emptyView, keyboardDismissView, tableViewArea)
        emptyView.addSubviews(emptyImageView, emptyLabel)
        tableViewArea.addSubviews(recentSearchLabel, clearRecentSearchButton, tableView)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        keyboardDismissView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.7)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.7 * (4 / 3))    // aspect ratio 4:3
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(emptyImageView.snp.width)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        tableViewArea.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(8)
        }
        
        clearRecentSearchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(recentSearchLabel)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        // 서치바
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        let searchBarImage = UIImage()  // 테두리 제거를 위한 백그라운드 이미지
        searchBar.backgroundImage = searchBarImage
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
        
        // keyboardDismiss 탭제스처 먹일 뷰
        keyboardDismissView.backgroundColor = .clear
        keyboardDismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss)))
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
        
        // delete cell handler
        cell.deletedHandler = {
            // reversed해서 뷰에 그리고 있으므로 삭제할 때도 index 뒤집기
            UserDefaultUtils.searchLogs.remove(at: UserDefaultUtils.searchLogs.count - indexPath.row - 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let log = UserDefaultUtils.searchLogs.reversed()[indexPath.row]
        
        search(log: log)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != "" else { return }
        let log = SearchLog(keyword: searchBar.text!)
        
        search(log: log)
    }
}
