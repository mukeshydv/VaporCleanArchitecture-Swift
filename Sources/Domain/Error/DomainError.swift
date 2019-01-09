//
//  DomainError.swift
//  Domain
//
//  Created by Mukesh on 09/01/19.
//

import Foundation

public enum DomainError: Error {
    case validationError(String)
    case notFoundError(String)
}
