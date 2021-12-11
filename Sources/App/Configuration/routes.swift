import Vapor
import Domain
import Data

/// Register your application's routes here.
public func routes(_ app: Application) throws {
    // Basic "It works" example
    app.get { req in
        return "It works!"
    }
    
    let provider = DBProvider(databases: app.databases, logger: app.logger)
    let repo = ProductRepository.create(for: provider)
    try app.register(collection: ProductController(
        findProductUseCase: GetProductByIdUseCase.create(repo),
        saveProductUseCase: CreateProductUseCase.create(repo)
    ))
}
