//
//  ItemInfo.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/23/24.
//

import Foundation
import Kingfisher

struct ItemInfo {
    let item: Item
    
    var title: String {
        return item.title.replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
    }
    
    var thumbnailImageURL: URL {
        return URL(string: item.image)!
    }
    
    var linkURL: URL {
        return URL(string: item.link)!
    }
    
    var lPrice: String {
        return Int(item.lprice)!.setComma()
    }
    
    var isWished: Bool {
        return UserDefaultUtils.wishes.contains(item.productId)
    }
}
