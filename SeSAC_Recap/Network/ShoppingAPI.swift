//
//  ShoppingAPI.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import Foundation
import Alamofire

class ShoppingAPI {
    static var start = 1
    static var paginationEnabled: Bool = pageRange ~= start
    static var pageRange = 1...1000
    
    static func getShopping(keyword: String, sortingType: SortingType, fetchType: FetchType, _ completion: @escaping ((Shopping) -> Void)) {
        switch fetchType {
        case .search:
            start = 1
        case .append:
            start += 1
        }
        
        let router = APIRouter(apiType: .shopping(keyword: keyword, sortingType: sortingType, start: ShoppingAPI.start))
        let url = router.requestURL
        
        AF.request(url, method: .get, headers: router.headers)
            .responseDecodable(of: Shopping.self) { response in
                switch response.result {
                case .success(let success):
                    ShoppingAPI.start += 1
                    completion(success)
                    
                case .failure(let failure):
                    print("ShoppingAPI getShopping 오류 발생", failure)
                }
            }
    }
}
