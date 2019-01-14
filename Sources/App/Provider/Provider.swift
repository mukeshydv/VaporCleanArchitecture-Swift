//
//  ProductProvider.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain
import Data

struct Provider: ProductProvider {
    private let repository: Domain.ProductRepository
    
    init(_ container: Container) throws {
        self.repository = try container.make(ProductRepository.self)
    }
    
    var findProductUseCase: UseCase<Int, Product> {
        return GetProductByIdUseCase.create(repository)
    }
    
    var saveProductUseCase: UseCase<Product, Void> {
        return CreateProductUseCase.create(repository)
    }
}

extension Provider: ServiceType {
    public static var serviceSupports: [Any.Type] = [ProductProvider.self]
    
    static func makeService(for worker: Container) throws -> Provider {
        return try .init(worker)
    }
}
