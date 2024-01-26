//
//  ErrorType.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/26/24.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case incorrectQuery = "SE01"
    case invalidDisplayValue = "SE02"
    case invalidStartValue = "SE03"
    case invalidSortValue = "SE04"
    case invalidSearchApi = "SE05"
    case malformedEncoding = "SE06" // 잘못된 형식의 인코딩
    case systemError = "SE99"
    case decodingErrorFail
    
    var message: String {
        switch self {
        case .systemError, .decodingErrorFail:
            return "데이터를 불러오는 데 실패했습니다."
        default:
            return "유효하지 않은 접근입니다."
        }
    }
}
