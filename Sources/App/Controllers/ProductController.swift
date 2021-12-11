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
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("product")
        
        group.get(":productId", use: getProduct)
        group.post(use: addProduct)
    }
    
    private let findProductUseCase: UseCase<Int, Product>
    private let saveProductUseCase: UseCase<Product, Void>
    
    init(
        findProductUseCase: UseCase<Int, Product>,
        saveProductUseCase: UseCase<Product, Void>
    ) {
        self.findProductUseCase = findProductUseCase
        self.saveProductUseCase = saveProductUseCase
    }
}

private extension ProductController {
    func getProduct(_ request: Request) throws -> Future<BaseResponse<ProductRequest>> {
        guard let id: Int = request.parameters.get("productId", as: Int.self) else {
            throw DomainError.validationError("productId not found")
        }
        return try findProductUseCase.executeResponse(from: request, body: id)
    }
    
    func addProduct(_ request: Request) throws -> Future<BaseResponse<Empty>> {
        try ProductRequest.validate(content: request)
        let product = try request.content.decode(ProductRequest.self)
        return try saveProductUseCase.executeResponse(from: request, body: product.toProduct)
    }
}
