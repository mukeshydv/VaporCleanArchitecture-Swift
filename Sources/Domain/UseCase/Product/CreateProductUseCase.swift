//
//  CreateProductUseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public struct CreateProductUseCase: AnyUseCase {
    private let repository: ProductRepository
    
    private init(_ repository: ProductRepository) {
        self.repository = repository
    }
    
    public func execute(request: RequestBody<Product>) throws -> Future<Void> {
        guard request.value.price > 0 else { throw DomainError.validationError("Price must not be negative") }
        
        return repository.save(product: request)
    }
}

extension CreateProductUseCase {
    public static func create(_ repository: ProductRepository) -> UseCase<Product, Void> {
        return UseCase(CreateProductUseCase(repository))
    }
}
