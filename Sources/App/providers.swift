//
//  providers.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain

extension Services {
    mutating func registerProviders() {
        register(Provider.self)
    }
}
