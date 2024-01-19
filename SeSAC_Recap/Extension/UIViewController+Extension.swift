//
//  UIViewController+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UIViewController {
    func configureView() {
        view.backgroundColor = .background
    }
}

extension UIViewController: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
