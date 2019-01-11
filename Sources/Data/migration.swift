//
//  migration.swift
//  Data
//
//  Created by Mukesh on 10/01/19.
//

import Foundation
import Fluent

extension MigrationConfig {
    mutating func addMigrations() {
        add(model: Product.self, database: .sqlite)
    }
}
