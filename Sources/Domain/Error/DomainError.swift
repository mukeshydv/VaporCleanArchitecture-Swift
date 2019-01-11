//
//  DomainError.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public enum DomainError: LocalizedError {
    case validationError(String)
    case notFoundError(String)
    case somethingWrong
    
    public var errorDescription: String? {
        switch self {
        case .validationError(let error):
            return error
        case .notFoundError(let error):
            return error
        case .somethingWrong:
            return "Something went wrong"
        }
    }
}
