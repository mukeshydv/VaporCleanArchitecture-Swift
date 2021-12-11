//
//  BaseResponse.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain

struct Empty: Content {
}

struct BaseResponse<T: Content>: Content {
    let status: Int
    let message: String
    let data: T?
}

extension DomainError {
    var toResponse: BaseResponse<Empty> {
        return BaseResponse(status: Int(status.code), message: localizedDescription, data: nil)
    }
    
    var status: HTTPStatus {
        switch self {
        case .notFoundError:
            return .notFound
        case .validationError:
            return .badRequest
        case .somethingWrong:
            return .internalServerError
        }
    }
}

protocol ResponseConvertible {
    associatedtype Response: Content
    var toResponse: Response { get }
}
