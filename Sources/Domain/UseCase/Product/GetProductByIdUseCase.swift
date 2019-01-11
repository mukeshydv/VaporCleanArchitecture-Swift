//
//  GetProductByIdUseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public struct GetProductByIdUseCase: AnyUseCase {
    
    private let repository: ProductRepository
    
    init(_ repository: ProductRepository) {
        self.repository = repository
    }
    
    public func execute(request: String) -> Future<Product> {
        return repository.getProductById(request)
    }
}

extension GetProductByIdUseCase {
    public static func create(_ repository: ProductRepository) -> UseCase<String, Product> {
        return UseCase(GetProductByIdUseCase(repository))
    }
}
