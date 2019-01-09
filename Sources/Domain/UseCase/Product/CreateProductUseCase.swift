//
//  CreateProductUseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public struct CreateProductUseCase: UseCase {
    private let repository: ProductRepository
    
    init(_ repository: ProductRepository) {
        self.repository = repository
    }
    
    public func execute(request: Product) throws -> Void {
        guard request.price > 0 else { throw DomainError.validationError("Price must not be negative") }
        
        repository.save(product: request)
    }
}
