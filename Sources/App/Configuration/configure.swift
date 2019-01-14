import Vapor
import Data

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    /// Register routes to the router
    services.register(Router.self) { (container) -> EngineRouter in
        let router = EngineRouter.default()
        try routes(router, container)
        return router
    }

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.addMiddlewares()
    
    services.register(middlewares)
    
    services.registerProviders()
    
    try configure(&services)
}
