//
//  ErrorMiddleware.swift
//  App
//
//  Created by Mukesh on 13/01/19.
//

import Foundation
import Vapor
import Domain

struct ErrorMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        return next.respond(to: request).flatMapError {
            let error: DomainError
            switch $0 {
            case let err as DomainError:
                error = err
            case let err as AbortError:
                error = DomainError.validationError(err.reason)
            default:
                error = DomainError.somethingWrong($0.localizedDescription)
            }
            return error.toResponse.encodeResponse(status: error.status, for: request)
        }
    }
}
