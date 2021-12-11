//
//  ProductRepository.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import NIO

public protocol ProductRepository {
    func getProductById(_ id: RequestBody<Int>) -> Future<Product>
    func save(product: RequestBody<Product>) -> Future<Void>
}
