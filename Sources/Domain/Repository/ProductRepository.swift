//
//  ProductRepository.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public protocol ProductRepository {
    func getProductById(_ id: String) -> Product?
    func save(product: Product)
}
