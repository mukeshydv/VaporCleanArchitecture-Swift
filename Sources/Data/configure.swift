//
//  configure.swift
//  VaporCleanArchitecture-Swift
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import FluentSQLite

public func databaseProvider() -> FluentSQLiteProvider {
    return FluentSQLiteProvider()
}

public func databaseConfig() throws -> DatabasesConfig {
    
    // Configure a database
    let database = try SQLiteDatabase(storage: .memory)
    
    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: database, as: .sqlite)
    
    return databases
}

public func migrationConfig() -> MigrationConfig {
    var migrations = MigrationConfig()
//    migrations.add(model: Todo.self, database: .sqlite)
    
    return migrations
}
