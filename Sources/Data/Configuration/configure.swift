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
    
    let files = FileManager.default
    
    #if os(Linux)
    let path = "/home/ubuntu/.db_configure.json"
    #else
    let path = "/Users/mukesh/.db_configure.json"
    #endif
    
    if let content = files.contents(atPath: path) {
        struct Connection: Decodable {
            let hostname: String
            let username: String
            let password: String
            let port: Int
            let database: String
        }
        
        let connection = try JSONDecoder().decode(Connection.self, from: content)
        
        let config = PostgreSQLDatabaseConfig(
            hostname: connection.hostname,
            port: connection.port,
            username: connection.username,
            database: connection.database)
        
        let database = PostgreSQLDatabase(config: config)
        
        /// Register the configured SQLite database to the database config.
        var databases = DatabasesConfig()
        databases.add(database: database, as: .psql)
        
        services.register(databases)
        
        /// Configure migrations
        var migrations = MigrationConfig()
        migrations.addMigrations()
        
        services.register(migrations)
    }
}
