//
//  AnyUseCase+Ext.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Domain

extension AnyUseCase where Response: ResponseConvertible {
    func executeResponse(_ request: Request) throws -> Future<BaseResponse<Response.Response>> {
        return try execute(request: request).map { BaseResponse(status: 200, message: "Success", data: $0.toResponse) }
    }
}

extension AnyUseCase where Response == Void {
    func executeResponse(_ request: Request) throws -> Future<BaseResponse<Empty>> {
        return try execute(request: request).map { BaseResponse<Empty>(status: 200, message: "Success", data: nil) }
    }
}
