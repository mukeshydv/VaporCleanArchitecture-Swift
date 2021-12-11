//
//  configure.swift
//  VaporCleanArchitecture-Swift
//
//  Created by Mukesh on 09/01/19.
//

import Foundation
import FluentKit
import FluentPostgresDriver

public func configure(_ databases: Databases, _ migrations: Migrations) throws {
    // Configure a database
    if let hostname = ProcessInfo.processInfo.environment["db_hostname"],
        let username = ProcessInfo.processInfo.environment["db_username"],
        let password = ProcessInfo.processInfo.environment["db_password"],
        let portString = ProcessInfo.processInfo.environment["db_port"],
        let database = ProcessInfo.processInfo.environment["db_database"],
        let port = Int(portString) {
        
        let config = PostgresConfiguration(
            hostname: hostname,
            port: port,
            username: username,
            password: password,
            database: database
        )
        databases.use(.postgres(configuration: config), as: .psql)
        migrations.addMigrations()
    } else {
        fatalError("Cannot connect to db")
    }
}

public struct DBProvider {
    private let databases: Databases
    private let logger: Logger
    
    public init(databases: Databases, logger: Logger) {
        self.databases = databases
        self.logger = logger
    }
    
    public func getDatabase(eventLoop: EventLoop) -> Database {
        return databases.database(
            logger: logger,
            on: eventLoop
        )!
    }
}
