//
//  GetProductByIdUseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
public struct GetProductByIdUseCase: UseCase {
    private let repository: ProductRepository
    
    init(_ repository: ProductRepository) {
        self.repository = repository
    }
    
    public func execute(request: String) throws -> Product {
        if let product = repository.getProductById(request) {
            return product
        }
        
        throw DomainError.notFoundError("Product with id: \(request) not found")
    }
}
