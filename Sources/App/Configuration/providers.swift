//
//  providers.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Service

extension Services {
    mutating func registerProviders() {
        register(Provider.self)
    }
}
