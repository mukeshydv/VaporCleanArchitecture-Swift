//
//  ErrorMiddleware.swift
//  App
//
//  Created by Mukesh on 13/01/19.
//

import Foundation
import Vapor
import Domain

struct ErrorMiddleware: Middleware, Service {
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        return try next.respond(to: request).catchFlatMap {
            let error = $0 as? DomainError ?? DomainError.somethingWrong($0.localizedDescription)
            return try error.toResponse.encode(for: request)
        }
    }
}
