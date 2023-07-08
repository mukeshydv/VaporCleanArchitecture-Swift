//
//  GetProductByIdUseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import NIOCore

public struct GetProductByIdUseCase: AnyUseCase {
    
    private let repository: ProductRepository
    
    private init(_ repository: ProductRepository) {
        self.repository = repository
    }
    
    public func execute(request: RequestBody<Int>) -> Future<Product> {
        return repository.getProductById(request)
    }
}

extension GetProductByIdUseCase {
    public static func create(_ repository: ProductRepository) -> UseCase<Int, Product> {
        return UseCase(GetProductByIdUseCase(repository))
    }
}
