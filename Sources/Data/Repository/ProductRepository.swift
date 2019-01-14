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
    
    private let db: Database.ConnectionPool
    
    public init(_ db: Database.ConnectionPool) {
        self.db = db
    }
    
    public func getProductById(_ id: Int) -> Future<Domain.Product> {
        return db.withConnection {
            return Product.find(id, on: $0)
                .unwrap(or: DomainError.notFoundError("Product with id: \(id) is not found."))
                .mapToDomain()
        }
    }
    
    public func save(product: Domain.Product) -> Future<Void> {
        return db.withConnection {
            return product.toData.save(on: $0).mapToVoid()
        }
    }
}

extension ProductRepository: ServiceType {
    public static var serviceSupports: [Any.Type] = [Domain.ProductRepository.self]
    
    public static func makeService(for worker: Container) throws -> ProductRepository {
        return .init(try worker.connectionPool())
    }
}
