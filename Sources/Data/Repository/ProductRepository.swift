//
//  ProductRepository.swift
//  Data
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import Domain
import Fluent

public struct ProductRepository: Domain.ProductRepository {
    
    private let conn: DatabaseConnectable
    
    public init(_ connection: DatabaseConnectable) {
        conn = connection
    }
    
    public func getProductById(_ id: Int) -> Future<Domain.Product> {
        return Product.find(id, on: conn)
            .unwrap(or: DomainError.notFoundError("Product with id: \(id) is not found."))
            .mapToDomain()
    }
    
    public func save(product: Domain.Product) -> Future<Void> {
        return product.toData.save(on: conn).mapToVoid()
    }
}
