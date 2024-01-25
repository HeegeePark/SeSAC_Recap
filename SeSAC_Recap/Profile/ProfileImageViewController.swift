//
//  ProfileImageViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

protocol ProfileImageDelegate {
    func selectImage(selectedImageIndex idx: Int)   // 선택한 이미지 idx return
}

class ProfileImageViewController: UIViewController {
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var imageCollectionView: UICollectionView!
    
    let list: [UIImage] = UIImage.Profile.list
    var selectedCellIndex: Int = 0
    
    var delegate: ProfileImageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.selectImage(selectedImageIndex: selectedCellIndex)
    }
    
    func setCurrentImage(imageIndex idx: Int) {
        selectedCellIndex = idx
    }
}

// MARK: Custom UI
extension ProfileImageViewController {
    override func configureView() {
        super.configureView()
        
        // TODO: 이전 화면에서 선택된 이미지로 세팅
        print(selectedCellIndex)
        selectedImageView.image = list[selectedCellIndex]
        selectedImageView.contentMode = .scaleAspectFill
        selectedImageView.layer.borderWidth = 5
        selectedImageView.layer.borderColor = UIColor.point.cgColor
        selectedImageView.setCornerRadius(style: .circle(selectedImageView))
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.title = "프로필 수정"
    }
    
    func configureCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        imageCollectionView.setLayout(inset: 20, spacing: 16, heightToWidthRatio: 1, colCount: 4)
        imageCollectionView.isScrollEnabled = false
        imageCollectionView.backgroundColor = .clear
    }
}

// MARK: UIColletionViewDelegate
extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        
        cell.isSelected = indexPath.item == selectedCellIndex
        cell.updateImage(image: list[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        
        selectedCellIndex = indexPath.item
        selectedImageView.image = list[selectedCellIndex]
        
        collectionView.reloadData()
    }
}
