//
//  ProductProvider.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation

public protocol ProductProvider {
    var findProductUseCase: UseCase<Int, Product> { get }
    var saveProductUseCase: UseCase<Product, Void> { get }
}
