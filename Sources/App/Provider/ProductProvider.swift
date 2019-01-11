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

struct Provider: ProductProvider, ServiceType {
    static var serviceSupports: [Any.Type] {
        return [ProductProvider.self]
    }
    
    static func makeService(for worker: Container) throws -> Provider {
        return Provider(worker)
    }
    
    private let conn: Container
    
    init(_ connection: Container) {
        conn = connection
    }
    
    func findProductUseCase() -> UseCase<Int, Product> {
        return GetProductByIdUseCase.create(ProductRepository(conn))
    }
    
    func saveProductUseCase() -> UseCase<Product, Void> {
        return CreateProductUseCase.create(ProductRepository(conn))
    }
}