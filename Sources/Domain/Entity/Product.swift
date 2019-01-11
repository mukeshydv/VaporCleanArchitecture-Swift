//
//  Product.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public struct Product {
    public let code: String?
    public let description: String
    public let price: Float80
    public let createdAt: Date
    
    public init(code: String?, description: String, price: Float80, createdAt: Date) {
        self.code = code
        self.description = description
        self.price = price
        self.createdAt = createdAt
    }
}
