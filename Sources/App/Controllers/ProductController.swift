//
//  ProductController.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain

final class ProductController: RouteCollection {
    func boot(router: Router) throws {
        let group = router.grouped("product")
        
        group.get("/", String.parameter, use: getProduct)
    }
}

extension ProductController {
    func getProduct(_ request: Request) throws -> Future<ProductResponse> {
        let id = try request.parameters.next(String.self)
        return try request.make(ProductProvider.self).createProductUseCase().execute(request: id).map { $0.toResponse }
    }
}

struct ProductResponse: Content {
    public let code: String?
    public let description: String
    public let price: Float
    public let createdAt: Date
}

extension Product {
    var toResponse: ProductResponse {
        return ProductResponse(code: code, description: description, price: Float(price), createdAt: createdAt)
    }
}
