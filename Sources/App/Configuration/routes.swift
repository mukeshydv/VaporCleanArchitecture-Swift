import Vapor
import Domain

/// Register your application's routes here.
public func routes(_ router: Router, _ container: Container) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }

    let provider = try container.make(ProductProvider.self)
    
    try router.register(collection: ProductController(provider))
}
