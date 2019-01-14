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
        
        group.get("/", Int.parameter, use: getProduct)
        group.post(ProductRequest.self, at: "/", use: addProduct)
    }
    
    private let provider: ProductProvider
    
    init(_ provider: ProductProvider) {
        self.provider = provider
    }
}

extension ProductController {
    private func getProduct(_ request: Request) throws -> Future<BaseResponse<ProductRequest>> {
        let id = try request.parameters.next(Int.self)
        return try provider.findProductUseCase.executeResponse(id)
    }
    
    private func addProduct(_ request: Request, _ product: ProductRequest) throws -> Future<BaseResponse<Empty>> {
        return try provider.saveProductUseCase.executeResponse(product.toProduct)
    }
}
