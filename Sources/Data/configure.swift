//
//  configure.swift
//  VaporCleanArchitecture-Swift
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import Fluent
import FluentSQLite

public func configure(_ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentSQLiteProvider())
    
    // Configure a database
    let database = try SQLiteDatabase(storage: .memory)
    
    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: database, as: .sqlite)
    
    services.register(databases)
    
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.addMigrations()
    
    services.register(migrations)
}
