//
//  repository.swift
//  App
//
//  Created by Mukesh on 14/01/19.
//

import Foundation
import Service

extension Services {
    mutating func registerRepositories() {
        register(ProductRepository.self)
    }
}
