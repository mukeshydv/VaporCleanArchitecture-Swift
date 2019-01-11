//
//  middlewares.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain

extension MiddlewareConfig {
    mutating func addMiddlewares() {
        use(FileMiddleware.self) // Serves files from `Public/` directory
        use(ErrorMiddlewareApp()) // Catches errors and converts to HTTP response
    }
}

struct ErrorMiddlewareApp: Middleware, Service {
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        return try next.respond(to: request).catchFlatMap {
            let error = $0 as? DomainError ?? DomainError.somethingWrong($0.localizedDescription)
            return try error.toResponse.encode(for: request)
        }
    }
}
