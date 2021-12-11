//
//  Product.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public struct Product {
    public let code: Int?
    public let description: String
    public let price: Float64
    public let createdAt: Date
    
    public init(code: Int?, description: String, price: Float64, createdAt: Date) {
        self.code = code
        self.description = description
        self.price = price
        self.createdAt = createdAt
    }
}
