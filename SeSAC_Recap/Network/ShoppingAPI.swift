//
//  ShoppingAPI.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import Foundation
import Alamofire

class ShoppingAPI {
    
    private init() { }
    
    typealias ShoppingResult = (Result<Shopping, NetworkError>) -> Void
    
    static var start = 1
    static var paginationEnabled: Bool = pageRange ~= start
    static var pageRange = 1...1000
    
    static func getShopping(keyword: String, sortingType: SortingType, fetchType: FetchType, _ completion: @escaping ShoppingResult) {
        if start != 1, fetchType == .search {
            start = 1
        }
        
        let router = APIRouter(apiType: .shopping(keyword: keyword, sortingType: sortingType, start: ShoppingAPI.start))
        
        guard let url = router.requestURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url, method: .get, headers: router.headers).validate(statusCode: 200..<300)
            .responseDecodable(of: Shopping.self) { response in
                switch response.result {
                case .success(let shopping):
                    start += 1
                    completion(.success(shopping))
                    
                case .failure(let failure):
                    print("ShoppingAPI getShopping 오류 발생", failure)
                    
                    // errorResponse 디코딩
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            print("Error Code: \(errorResponse.errorCode)")
                            print("Error Message: \(errorResponse.errorMessage)")
                            
                            guard let networkError: NetworkError = .init(rawValue: errorResponse.errorCode) else { return }
                            completion(.failure(networkError))
                            
                        } catch {
                            print("Error decoding error response: \(error)")
                            completion(.failure(.decodingErrorFail))
                        }
                    }
                    completion(.failure(.decodingErrorFail))
                }
            }
    }
    
    static func request(keyword: String, sortingType: SortingType, fetchType: FetchType) async throws -> Shopping {
        let router = APIRouter(apiType: .shopping(keyword: keyword, sortingType: sortingType, start: ShoppingAPI.start))
        
        guard let url = router.requestURL else {
            throw NetworkError.invalidURL
        }
        
        let request = AF.request(url, method: .get, headers: router.headers).validate(statusCode: 200..<300)
        let dataTask = request.serializingDecodable(Shopping.self)
        
        switch await dataTask.result {
        case .success(let shopping):
            return shopping
        
        case.failure(let error):
            if let data = await dataTask.response.data {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print("Error Code: \(errorResponse.errorCode)")
                    print("Error Message: \(errorResponse.errorMessage)")
                    
                    guard let networkError: NetworkError = .init(rawValue: errorResponse.errorCode) else {
                        throw NetworkError.decodingErrorFail
                    }
                    throw networkError
                    
                } catch {
                    print("Error decoding error response: \(error)")
                    throw NetworkError.decodingErrorFail
                }
            }
            throw NetworkError.decodingErrorFail
        }
    }
}
