//
//  APIType.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import Foundation
import Alamofire

enum APIType {
    case shopping(keyword: String, sortingType: SortingType)
}

extension APIType {
    var baseURL: String {
        switch self {
        case .shopping:
            return BASEURL.shopping
        }
    }
}

enum SortingType: String, CaseIterable {
    case sim
    case date
    case asc
    case dsc
    
    var title: String {
        switch self {
        case .sim:
            return "정확도순"
        case .date:
            return "날짜순"
        case .asc:
            return "가격낮은순"
        case .dsc:
            return "가격높은순"
        }
    }
}
