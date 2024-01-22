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
        case .shopping(let keyword, let sortingType):
            return [URLQueryItem(name: "query", value: keyword),
                    URLQueryItem(name: "display", value: "10"),
                    URLQueryItem(name: "sort", value: sortingType.rawValue)]
        
        }
    }
    
    init(apiType: APIType) {
        self.apiType = apiType
    }
    
    var requestURL: String {
        var components = URLComponents(string: apiType.baseURL)!
        
        if let items = queryItems {
            components.queryItems = items
        }
        
        return components.string!
    }
}
