//
//  SearchResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    
    @IBOutlet var resultCountLabel: UILabel!
    @IBOutlet var sortedButton: [UIButton]!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var keyword: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureCollectionView()
    }
    
    func updateKeyword(log: SearchLog) {
        keyword = log.keyword
    }

}

// MARK: - Custom UI
extension SearchResultViewController: UICollectionViewControllerProtocol {
    override func configureView() {
        super.configureView()
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
    }
    
    func configureLayout() {
        collectionView.setLayout(inset: 8, spacing: 8, heightToWidthRatio: 1.3, colCount: 2)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        return cell
    }
}
