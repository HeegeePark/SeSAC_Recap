//
//  SearchResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

enum FetchType {
    case search
    case append
}

class SearchResultViewController: UIViewController {
    
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var resultCountLabel: UILabel!
    @IBOutlet var sortedButton: [UIButton]!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var emptyLabel: UILabel!
    
    var keyword: String = ""
    var items: [Item]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var resultTotalCount = 0 {
        didSet {
            self.resultCountLabel.text = "\(resultTotalCount.setComma()) 개의 검색 결과"
        }
    }
    
    var currentSortedButtonIndex = 0 {
        didSet {
            for button in sortedButton {
                if button.tag == currentSortedButtonIndex {
                    button.setTitleColor(.black, for: .normal)
                    button.backgroundColor = .white
                } else {
                    button.setTitleColor(.white, for: .normal)
                    button.backgroundColor = .clear
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureCollectionView()
        
        fetchResultItems(sortingType: .sim, fetchType: .search)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func updateKeyword(log: SearchLog) {
        keyword = log.keyword
    }
    
    func fetchResultItems(sortingType: SortingType, fetchType: FetchType) {
        ShoppingAPI.getShopping(keyword: keyword, sortingType: sortingType, fetchType: fetchType) { result in
            switch result {
            case .success(let shopping):
                // 검색 결과가 없다면
                guard shopping.total != 0 else {
                    if fetchType == .search {
                        self.resultTotalCount = shopping.total
                        self.collectionView.isHidden = true
                    }
                    return
                }
                
                switch fetchType {
                case .search:
                    self.resultTotalCount = shopping.total
                                    
                    self.items = shopping.items
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    
                case .append:
                    self.items! += shopping.items
                }
                
            case .failure(let error):
                if fetchType == .search {
                    self.headerView.isHidden = true
                }
                
                self.presentAlert(alertInfo: Alert(title: nil, message: error.message, style: .alert, actions: [UIAlertAction(title: "확인", style: .default)]))
            }
        }
    }
    
    @objc func sortedButtonClicked(_ sender: UIButton) {
        currentSortedButtonIndex = sender.tag
        
        fetchResultItems(sortingType: SortingType.allCases[currentSortedButtonIndex], fetchType: .search)
    }

}

// MARK: - Custom UI
extension SearchResultViewController: UICollectionViewControllerProtocol {
    override func configureView() {
        super.configureView()
        
        // 검색 결과 개수
        resultCountLabel.font = .sf13Bold
        resultCountLabel.textColor = .point
        
        // 정렬 버튼
        for (i, button) in sortedButton.enumerated() {
            button.tag = i
            button.setTitle(SortingType.allCases[i].title, for: .normal)
            button.titleLabel?.font = .sf13
            if i == currentSortedButtonIndex {
                button.setTitleColor(.black, for: .normal)
            } else {
                button.setTitleColor(.white, for: .normal)
            }
            
            button.backgroundColor = currentSortedButtonIndex == i ? .white: .clear
            button.setCornerRadius(style: .small)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.sizeToFit()
            button.contentEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 4)
            button.addTarget(self, action: #selector(sortedButtonClicked), for: .touchUpInside)
        }
        
        // 검색 결과 없을 때 띄울 레이블
        emptyLabel.text = "검색 결과를 찾을 수 없어요."
        emptyLabel.font = .sf15Bold
        emptyLabel.textColor = .text
        emptyLabel.textAlignment = .center
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        navigationItem.title = keyword
    }
    
    func configureCollectionView() {
        registerXib()
        connectDelegate()
        configureLayout()
    }
    
    func registerXib() {
        let xib = UINib(nibName: SearchResultCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func connectDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
    }
    
    func configureLayout() {
        collectionView.setLayout(inset: 8, spacing: 8, heightToWidthRatio: 1.5, colCount: 2)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        guard let item = items?[indexPath.item] else { return UICollectionViewCell() }
        
        cell.bindItem(item: item)
        
        cell.wishedHandler = { isWished in
            if isWished {
                UserDefaultUtils.wishes.insert(item.productId)
            } else {
                UserDefaultUtils.wishes.remove(item.productId)
            }
            print(UserDefaultUtils.wishes)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = items?[indexPath.item] else { return }
        
        let vc = loadViewController(storyboardToPushIdentifier: nil, viewControllerToChange: SearchDetailViewController.self)
        
        vc.updateItem(item: item)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// TODO: Pagination
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if items!.count - 3 == item.row {
                guard items!.count < resultTotalCount else { return }
                if ShoppingAPI.paginationEnabled  {
                    fetchResultItems(sortingType: SortingType.allCases[currentSortedButtonIndex], fetchType: .append)
                }
            }
        }
    }
}
