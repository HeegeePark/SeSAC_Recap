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
    
    
    @IBOutlet var resultCountLabel: UILabel!
    @IBOutlet var sortedButton: [UIButton]!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var keyword: String = ""
    var items: [Item]? {
        didSet {
            collectionView.reloadData()
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
    
    func updateKeyword(log: SearchLog) {
        keyword = log.keyword
    }
    
    func fetchResultItems(sortingType: SortingType, fetchType: FetchType) {
        switch fetchType {
        case .search:
            ShoppingAPI.start = 1
            ShoppingAPI.getShopping(keyword: keyword, sortingType: sortingType, fetchType: fetchType) { Shopping in
                self.resultCountLabel.text = "\(Shopping.total.setComma()) 개의 검색 결과"
                self.items = Shopping.items
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
         
        case .append:
            ShoppingAPI.start += 1
            ShoppingAPI.getShopping(keyword: keyword, sortingType: sortingType, fetchType: fetchType) { Shopping in
                self.items! += Shopping.items
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
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        navigationItem.title = keyword
        setBackButtonInNavigationBar()
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
        print("items count: \(items?.count)")
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        if let item = items?[indexPath.item] {
            cell.bindItem(item: item)
        }
        
        cell.wishedHandler = {
            // TODO: UserDefaults에 좋아요 반영
        }
        
        return cell
    }
}

// TODO: Pagination
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if items!.count - 3 == item.row {
                if !ShoppingAPI.isEnd {
                    fetchResultItems(sortingType: SortingType.allCases[currentSortedButtonIndex], fetchType: .append)
                }
            }
        }
    }
}
