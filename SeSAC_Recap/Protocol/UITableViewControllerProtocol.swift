//
//  UITableViewControllerProtocol.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

protocol UITableViewControllerProtocol: UIViewController {
    func configureTableView()
    func registerXib()
    func connectDelegate()
}
