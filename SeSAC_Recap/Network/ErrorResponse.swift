//
//  Error.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/26/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let errorMessage: String
    let errorCode: String
}
