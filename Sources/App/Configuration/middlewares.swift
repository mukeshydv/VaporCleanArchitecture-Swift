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
        use(ErrorMiddleware()) // Catches errors and converts to HTTP response
    }
}
