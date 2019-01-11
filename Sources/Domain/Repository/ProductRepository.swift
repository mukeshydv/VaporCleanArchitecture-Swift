//
//  ProductRepository.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public protocol ProductRepository {
    func getProductById(_ id: Int) -> Future<Product>
    func save(product: Product) -> Future<Void>
}
