//
//  ProductDto.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain

struct ProductRequest: Content {
    public let code: Int?
    public let description: String
    public let price: Float
    public let createdAt: Date
}

extension ProductRequest {
    var toProduct: Product {
        return Product(code: code, description: description, price: Float80(price), createdAt: createdAt)
    }
}

extension Product: ResponseConvertible {
    var toResponse: ProductRequest {
        return ProductRequest(code: code, description: description, price: Float(price), createdAt: createdAt)
    }
}
