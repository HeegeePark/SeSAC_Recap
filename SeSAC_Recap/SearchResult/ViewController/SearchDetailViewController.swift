//
//  SearchDetailViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/23/24.
//

import UIKit
import WebKit

class SearchDetailViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var itemInfo: ItemInfo?
    var productId: String?
    var isWished: Bool = false {
        didSet {
            if isWished {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: SFSymbol.heartFill)
            } else {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: SFSymbol.heart)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureNavigationBar()
        loadWebView()
    }
    
    func loadWebView() {
        if let info = itemInfo {
            let request = URLRequest(url: info.linkURL)
            
            webView.load(request)
        }
    }
    
    func updateItem(item: Item) {
        itemInfo = ItemInfo(item: item)
        productId = item.productId
    }
    
    @objc func wishButtonTapped() {
        isWished.toggle()
        
        if isWished {
            UserDefaultUtils.wishes.insert(productId!)
        } else {
            UserDefaultUtils.wishes.remove(productId!)
        }
    }
}

// MARK: - Custom UI
extension SearchDetailViewController {
    override func configureView() {
        super.configureView()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        if let info = itemInfo {
            navigationItem.title = info.title
            
            isWished = info.isWished
            
            let imageStr = !isWished ? SFSymbol.heart: SFSymbol.heartFill
            let wishButton = UIBarButtonItem(image: UIImage(systemName: imageStr), style: .plain, target: self, action: #selector(wishButtonTapped))
            navigationItem.rightBarButtonItem = wishButton
        }
    }
}
