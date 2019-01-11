//
//  UseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import NIO

public typealias Future = EventLoopFuture

public protocol AnyUseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) throws -> Future<Response>
}

public struct UseCase<Request, Response>: AnyUseCase {
    
    private let _execute: (_ request: Request) throws -> Future<Response>
    
    public init<U: AnyUseCase>(_ useCase: U) where U.Request == Request, U.Response == Response {
        _execute = useCase.execute
    }
    
    public func execute(request: Request) throws -> Future<Response> {
        return try _execute(request)
    }
}
