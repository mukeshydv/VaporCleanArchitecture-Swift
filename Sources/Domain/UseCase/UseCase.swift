//
//  UseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) throws -> Response
}

public struct AnyUseCase<U: UseCase>: UseCase {
    
    private let _useCase: U
    
    public init(_ useCase: U) {
        _useCase = useCase
    }
    
    public func execute(request: U.Request) throws -> U.Response {
        return try _useCase.execute(request: request)
    }
}
