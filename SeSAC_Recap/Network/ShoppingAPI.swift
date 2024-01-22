//
//  ShoppingAPI.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import Foundation
import Alamofire

class ShoppingAPI {
    static var page = 1
    
    static func getShopping(keyword: String, sortingType: SortingType, _ completion: @escaping (([Item]) -> Void)) {
        let url = APIRouter(apiType: .shopping(keyword: keyword, sortingType: sortingType)).requestURL
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.naver,
                                    "X-Naver-Client-Secret": APIKey.naverSecret]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: Shopping.self) { response in
                switch response.result {
                case .success(let success):
                    completion(success.items)
                    
                case .failure(let failure):
                    print("ShoppingAPI getShopping 오류 발생", failure)
                }
            }
    }
}
