//
//  ProductDto.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain

struct ProductRequest: Content, Validatable {
    public let code: Int?
    public let description: String
    public let price: Double
    public let createdAt: Date
    
    static func validations(_ validations: inout Validations) {
        validations.add("description", as: String.self, is: !.empty)
        validations.add("price", as: Double.self, is: .range(PartialRangeFrom(0)))
    }
}

extension ProductRequest {
    var toProduct: Product {
        return Product(code: code, description: description, price: price, createdAt: createdAt)
    }
}

extension Product: ResponseConvertible {
    var toResponse: ProductRequest {
        return ProductRequest(code: code, description: description, price: price, createdAt: createdAt)
    }
}
