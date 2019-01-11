//
//  CreateProductUseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public struct CreateProductUseCase: AnyUseCase {
    private let repository: ProductRepository
    
    init(_ repository: ProductRepository) {
        self.repository = repository
    }
    
    public func execute(request: Product) throws -> Future<Void> {
        guard request.price > 0 else { throw DomainError.validationError("Price must not be negative") }
        
        return repository.save(product: request)
    }
}
