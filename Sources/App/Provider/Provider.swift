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
    private let conn: DatabaseConnectable
    
    init(_ connection: DatabaseConnectable) {
        conn = connection
    }
    
    var findProductUseCase: UseCase<Int, Product> {
        return GetProductByIdUseCase.create(ProductRepository(conn))
    }
    
    var saveProductUseCase: UseCase<Product, Void> {
        return CreateProductUseCase.create(ProductRepository(conn))
    }
}
