//
//  ProductProvider.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation

public protocol ProductProvider {
    func createProductUseCase() -> UseCase<String, Product>
}
