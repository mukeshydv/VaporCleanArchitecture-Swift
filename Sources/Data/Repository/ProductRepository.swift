//
//  ProductRepository.swift
//  Data
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import Domain
import FluentSQLite

public struct ProductRepository: Domain.ProductRepository {
    
    private let conn: Container
    
    public init(_ connection: Container) {
        conn = connection
    }
    
    public func getProductById(_ id: String) -> Future<Domain.Product> {
        return conn.newConnection(to: .sqlite).flatMap {
            Product.find(id, on: $0)
                .unwrap(or: DomainError.notFoundError("Product with id: \(id) is not found."))
                .mapToDomain()
        }
    }
    
    public func save(product: Domain.Product) -> Future<Void> {
        return conn.newConnection(to: .sqlite).flatMap {
            return product.toData.save(on: $0).mapToVoid()
        }
    }
}
