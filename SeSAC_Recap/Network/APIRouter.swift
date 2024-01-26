//
//  APIRouter.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import Foundation
import Alamofire

class APIRouter {
    
    var apiType: APIType
    
    var queryItems: [URLQueryItem]? {
        switch apiType {
        case .shopping(let keyword, let sortingType, let start):
            return [URLQueryItem(name: "query", value: keyword),
                    URLQueryItem(name: "display", value: "30"),
                    URLQueryItem(name: "sort", value: sortingType.rawValue),
                    URLQueryItem(name: "start", value: "\(start)")]
        
        }
    }
    
    init(apiType: APIType) {
        self.apiType = apiType
    }
    
    var headers: HTTPHeaders {
        switch apiType {
        case .shopping(let keyword, let sortingType, let start):
            return ["X-Naver-Client-Id": APIKey.naver,
                    "X-Naver-Client-Secret": APIKey.naverSecret]
        }
    }
    
    var requestURL: String? {
        var components = URLComponents(string: apiType.baseURL)!
        
        if let items = queryItems {
            components.queryItems = items
        }
        
        return components.string
    }
}
