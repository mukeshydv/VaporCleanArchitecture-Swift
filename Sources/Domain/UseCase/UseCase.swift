//
//  UseCase.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import NIO

public struct RequestBody<Request>: CustomStringConvertible {
    public let value: Request
    public let eventLoop: EventLoop
    
    public init(request: Request, eventLoop: EventLoop) {
        self.value = request
        self.eventLoop = eventLoop
    }
    
    public var description: String {
        return String(describing: value)
    }
}

public typealias Future = EventLoopFuture

public protocol AnyUseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: RequestBody<Request>) throws -> Future<Response>
}

public struct UseCase<Request, Response>: AnyUseCase {
    
    private let _execute: (RequestBody<Request>) throws -> Future<Response>
    
    public init<U: AnyUseCase>(_ useCase: U) where U.Request == Request, U.Response == Response {
        _execute = useCase.execute
    }
    
    public func execute(request: RequestBody<Request>) throws -> Future<Response> {
        return try _execute(request)
    }
}
