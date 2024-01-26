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
            case goToStart = "처음부터 시작하기"
            
            var isSelectionEnabled: Bool {
                switch self {
                case .goToStart:
                    return true
                default:
                    return false
                }
            }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
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
        let sectionType = SettingCell.allCases[indexPath.section]
        
        switch sectionType {
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingProfileTableViewCell.identifier, for: indexPath) as! SettingProfileTableViewCell
            
            cell.updateProfile()
            
            return cell
        case .options:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "SettingCell")
            
            let cellType = SettingCell.Options.allCases[indexPath.row]
            
            cell.textLabel?.text = cellType.rawValue
            cell.textLabel?.font = .sf13
            
            cell.selectionStyle = cellType.isSelectionEnabled ? .default: .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingCell.allCases[indexPath.section] {
        case .profile:
            let vc = loadViewController(storyboardToPushIdentifier: StoryboardId.profile, viewControllerToChange: ProfileViewController.self)
            vc.fromWhereType = .setting
            
            navigationController?.pushViewController(vc, animated: true)
            
        case .options:
            guard SettingCell.Options.allCases[indexPath.row] == .goToStart else { return }
            
            let alertInfo = Alert(title: "처음부터 시작하기",
                                  message: "데이터를 모두 초기화하시겠습니까?",
                                  style: .alert,
                                  actions: [UIAlertAction(title: "취소", style: .cancel),
                                            UIAlertAction(title: "확인", style: .default) { _ in
                // 데이터 리셋
                UserDefaultUtils.reset()
                // change rootVC
                self.changeRootViewController(storyboardToPushIdentifier: StoryboardId.onboarding, viewControllerToChange: OnboardingViewController.self, isNeedNavigationController: true)
            }
                                           ])
            presentAlert(alertInfo: alertInfo)
        }
    }
}
