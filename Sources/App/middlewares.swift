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
            let error = $0 as? DomainError ?? DomainError.somethingWrong
            
            let res = request.response()
            try res.content.encode(error, as: .json)
            return Future.map(on: request) { res }
        }
    }
}

extension DomainError: Encodable {
    enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(statusCode, forKey: .status)
        try container.encode(localizedDescription, forKey: .message)
    }
    
    var statusCode: Int {
        switch self {
        case .notFoundError:
            return 404
        case .validationError:
            return 400
        case .somethingWrong:
            return 500
        }
    }
}
