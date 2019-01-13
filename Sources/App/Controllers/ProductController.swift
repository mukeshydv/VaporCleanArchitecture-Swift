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
        group.post("/", use: addProduct)
    }
}

extension ProductController {
    private func getProduct(_ request: Request) throws -> Future<BaseResponse<ProductDto>> {
        let id = try request.parameters.next(Int.self)
        return try request.make(ProductProvider.self).findProductUseCase.executeResponse(id)
    }
    
    private func addProduct(_ request: Request) throws -> Future<BaseResponse<Empty>> {
        return try request.content.decode(ProductDto.self).flatMap {
            return try request.make(ProductProvider.self).saveProductUseCase.executeResponse($0.toProduct)
        }
    }
}
