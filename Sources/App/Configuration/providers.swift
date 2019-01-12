//
//  providers.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Vapor
import Domain

extension DatabaseConnectable {
    func make(_ type: ProductProvider.Protocol) -> ProductProvider {
        return Provider(self)
    }
}
