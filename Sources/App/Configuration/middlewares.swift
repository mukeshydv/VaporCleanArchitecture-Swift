//
//  middlewares.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor

extension Middlewares {
    mutating func addMiddlewares() {
        use(ErrorMiddleware()) // Catches errors and converts to HTTP response
    }
}
