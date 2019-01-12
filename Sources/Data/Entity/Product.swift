//
//  Product.swift
//  Data
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import Domain
import Fluent

struct Product: DBModel {
    var id: Int?
    var description: String
    var price: Float64
    var createdAt: Date
}

extension Product: Migration { }

extension Product: DomainConvertible {
    var toDomain: Domain.Product {
        return Domain.Product(
            code: id,
            description: description,
            price: Float80(price),
            createdAt: createdAt
        )
    }
}

extension Domain.Product {
    var toData: Product {
        return Product(
            id: code,
            description: description,
            price: Float64(price),
            createdAt: createdAt
        )
    }
}
