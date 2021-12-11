//
//  Product.swift
//  Data
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import Domain
import FluentKit

final class Product: Model {
    static var schema: String = "products"
    
    init() { }
    
    @ID(custom: "id")
    var id: Int?
    @Field(key: "description")
    var description: String
    @Field(key: "price")
    var price: Double
    @Timestamp(key: "created_at", on: .create, format: .iso8601)
    var createdAt: Date?
}

extension Product {
    struct Create: Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            return database.schema(Product.schema)
                .id()
                .field("description", .string)
                .field("price", .double)
                .field("createdAt", .datetime)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            return database.schema(Product.schema).delete()
        }
    }
    
    struct UpdateCreatedAt: Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            return database.schema(Product.schema)
                .deleteField("createdAt")
                .deleteField("id")
                .field("created_at", .string)
                .field("id", .int64, .identifier(auto: true))
                .update()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            return database.schema(Product.schema)
                .deleteField("id")
                .deleteField("created_at")
                .id()
                .field("createdAt", .datetime)
                .update()
        }
    }
}

extension Product: DomainConvertible {
    var toDomain: Domain.Product {
        return Domain.Product(
            code: id,
            description: description,
            price: price,
            createdAt: createdAt ?? Date()
        )
    }
}

extension Domain.Product {
    var toData: Product {
        let product = Product()
        product.id = code
        product.description = description
        product.price = price
        product.createdAt = createdAt
        return product
    }
}
