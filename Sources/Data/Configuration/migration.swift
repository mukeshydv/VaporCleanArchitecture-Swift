//
//  migration.swift
//  Data
//
//  Created by Mukesh on 10/01/19.
//

import Foundation
import FluentKit

extension Migrations {
    func addMigrations() {
        self.add([
            Product.Create(),
            Product.UpdateCreatedAt()
        ])
    }
}
