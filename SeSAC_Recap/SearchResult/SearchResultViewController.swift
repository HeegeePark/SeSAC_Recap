//
//  SearchResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import UIKit

class SearchResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateKeyword(log: SearchLog) {
        navigationItem.title = log.keyword
    }

}
