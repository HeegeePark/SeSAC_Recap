//
//  ProfileImageViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class ProfileImageViewController: UIViewController {
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var imageCollectionView: UICollectionView!
    
    let list: [UIImage] = UIImage.Profile.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureNavigationBar()
        configureCollectionView()
    }
}

// MARK: Custom UI
extension ProfileImageViewController {
    override func configureView() {
        super.configureView()
        
        // TODO: 이전 화면에서 선택된 이미지로 세팅
        selectedImageView.image = .Profile[3]
        selectedImageView.contentMode = .scaleAspectFill
        selectedImageView.layer.borderWidth = 5
        selectedImageView.layer.borderColor = UIColor.point.cgColor
        selectedImageView.setCornerRadius(style: .circle(selectedImageView))
    }
    
    override func configureNavigationBar() {
        navigationItem.title = "프로필 수정"
        
        setBackButtonInNavigationBar()
    }
    
    override func configureCollectionView() {
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
        
        cell.configureImage(image: list[indexPath.item])
        
        return cell
    }
}

// MARK: - Preview

import SwiftUI
struct PreView: PreviewProvider {
    static var previews: some View {
        let vc = UIStoryboard(name: StoryboardId.profile, bundle: nil)
            .instantiateViewController(withIdentifier: ProfileImageViewController.identifier)
        vc.toPreview()
    }
}
