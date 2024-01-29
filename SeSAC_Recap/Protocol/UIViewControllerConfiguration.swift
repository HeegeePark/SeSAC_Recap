//
//  UIViewControllerConfiguration.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

@objc
protocol UIViewControllerConfiguration: AnyObject {
    func configureHierarchy()
    func setupConstraints()
    func configureView()
    @objc optional func configureNavigationBar()
    @objc optional func configureTableView()
    @objc optional func configureCollectionView()
}
