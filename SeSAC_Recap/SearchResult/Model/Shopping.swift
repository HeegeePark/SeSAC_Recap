//
//  Shopping.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import Foundation

// MARK: - Shopping
struct Shopping: Codable {
    let total: Int
    let items: [Item]
    let start: Int
}

// MARK: - Item
struct Item: Codable {
    let productId: String
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
}
