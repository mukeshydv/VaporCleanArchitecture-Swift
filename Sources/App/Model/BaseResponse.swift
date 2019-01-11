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
    var statusCode: Int {
        switch self {
        case .notFoundError:
            return 404
        case .validationError:
            return 400
        case .somethingWrong:
            return 500
        }
    }
    
    var toResponse: BaseResponse<Empty> {
        return BaseResponse(status: statusCode, message: localizedDescription, data: nil)
    }
}

protocol ResponseConvertible {
    associatedtype Response: Content
    var toResponse: Response { get }
}
