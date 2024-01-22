//
//  UICollectionViewControllerProtocol.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

protocol UICollectionViewControllerProtocol: UIViewController {
    func configureCollectionView()
    func registerXib()
    func connectDelegate()
    func configureLayout()
}
