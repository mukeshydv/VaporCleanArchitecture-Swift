//
//  ProductRepository.swift
//  Data
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import Domain
import FluentKit

public struct ProductRepository: Domain.ProductRepository {
    
    private let db: DBProvider
    public init(_ db: DBProvider) {
        self.db = db
    }
    
    public func getProductById(_ id: RequestBody<Int>) -> Future<Domain.Product> {
        return db.getDatabase(eventLoop: id.eventLoop).withConnection {
            return Product.find(id.value, on: $0)
                .unwrap(orError: DomainError.notFoundError("Product with id: \(id) is not found."))
                .mapToDomain()
        }
    }
    
    public func save(product: RequestBody<Domain.Product>) -> Future<Void> {
        return db.getDatabase(eventLoop: product.eventLoop).withConnection {
            return product.value.toData.save(on: $0).mapToVoid()
        }
    }
}

extension Domain.ProductRepository {
    public static func create(for db: DBProvider) -> Domain.ProductRepository {
        return ProductRepository(db)
    }
}
