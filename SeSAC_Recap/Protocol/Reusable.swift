//
//  Reusable.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import Foundation

protocol Reusable: AnyObject {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
