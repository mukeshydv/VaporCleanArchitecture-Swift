//
//  configure.swift
//  VaporCleanArchitecture-Swift
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import Fluent
import FluentPostgreSQL

public typealias DBModel = PostgreSQLModel

public func configure(_ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentPostgreSQLProvider())
    
    // Configure a database
    if let hostname = Environment.get("db_hostname"),
        let username = Environment.get("db_username"),
        let portString = Environment.get("db_port"),
        let database = Environment.get("db_database"),
        let port = Int(portString) {
        
        let config = PostgreSQLDatabaseConfig(
            hostname: hostname,
            port: port,
            username: username,
            database: database
        )
        
        let database = PostgreSQLDatabase(config: config)
        
        /// Register the configured PostgreSQL database to the database config.
        var databases = DatabasesConfig()
        databases.add(database: database, as: .psql)
        databases.enableLogging(on: .psql)
        
        services.register(databases)
        
        /// Configure migrations
        var migrations = MigrationConfig()
        migrations.addMigrations()
        
        services.register(migrations)
    } else {
        fatalError("Cannot connect to db")
    }
    
    services.registerRepositories()
}

extension Database {
    public typealias ConnectionPool = DatabaseConnectionPool<ConfiguredDatabase<PostgreSQLDatabase>>
}

extension Container {
    func connectionPool() throws -> DatabaseConnectionPool<ConfiguredDatabase<PostgreSQLDatabase>> {
        return try connectionPool(to: .psql)
    }
}
