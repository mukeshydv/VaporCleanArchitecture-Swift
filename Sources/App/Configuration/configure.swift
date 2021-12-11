import Vapor
import Data
import Fluent

/// Application configuration
public func configure(_ app: Application) throws {
    /// Register middleware
    app.middleware.addMiddlewares()
    
    try configure(app.databases, app.migrations)
    try app.autoMigrate().wait()
    try routes(app)
}
