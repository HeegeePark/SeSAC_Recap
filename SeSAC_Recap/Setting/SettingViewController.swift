//
//  SettingViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    enum SettingCell: CaseIterable {
        case profile
        case options
        
        enum Options: String, CaseIterable {
            case notice = "공지사항"
            case faq = "자주 묻는 질문"
            case inquiryForOneToOne = "1:1 문의"
            case notificationSetting = "알림 설정"
            case gotoStart = "처음부터 시작하기"
        }
        
        static var sectionCount: Int {
            return SettingCell.allCases.count
        }
        
        var cellCount: Int {
            switch self {
            case .profile:
                return 1
            case .options:
                return Options.allCases.count
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureNavigationBar()
        configureTableView()
    }
}

// MARK: - Custom UI
extension SettingViewController: UITableViewControllerProtocol {
    override func configureView() {
        super.configureView()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        navigationItem.title = "설정"
    }
    
    func configureTableView() {
        registerXib()
        connectDelegate()
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerXib() {
        let xib = UINib(nibName: SettingProfileTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: SettingProfileTableViewCell.identifier)
    }
    
    func connectDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingCell.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingCell.allCases[section].cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = SettingCell.allCases[indexPath.section]
        
        switch cellType {
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as! SettingProfileTableViewCell
            
            return cell
        case .options:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "SettingCell")
            
            cell.textLabel?.text = SettingCell.Options.allCases[indexPath.row].rawValue
            cell.textLabel?.font = .sf13
            
            return cell
        }
    }
}
