//
//  Converter.swift
//  App
//
//  Created by Mukesh on 10/01/19.
//

import Foundation
import Domain

protocol DomainConvertible {
    associatedtype DomainType
    var toDomain: DomainType { get }
}

extension Future where Value: DomainConvertible {
    func mapToDomain<D>() -> Future<D> where D == Value.DomainType {
        return map {
            $0.toDomain
        }
    }
}

extension Future {
    func mapToVoid() -> Future<Void> {
        return map { _ -> Void in }
    }
}
