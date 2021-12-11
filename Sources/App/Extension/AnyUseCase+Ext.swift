//
//  AnyUseCase+Ext.swift
//  App
//
//  Created by Mukesh on 11/01/19.
//

import Foundation
import Domain
import Vapor

extension AnyUseCase where Response: ResponseConvertible {
    func executeResponse(from request: Vapor.Request, body: Request) throws -> Future<BaseResponse<Response.Response>> {
        return try execute(request: eventLoopRequest(body, eventLoop: request.eventLoop))
            .map { BaseResponse(status: 200, message: "Success", data: $0.toResponse) }
    }
}

extension AnyUseCase where Response == Void {
    func executeResponse(from request: Vapor.Request, body: Request) throws -> Future<BaseResponse<Empty>> {
        return try execute(
            request: eventLoopRequest(body, eventLoop: request.eventLoop)
        ).map { BaseResponse<Empty>(status: 200, message: "Success", data: nil) }
    }
}

private func eventLoopRequest<T>(_ value: T, eventLoop: EventLoop) -> RequestBody<T> {
    return RequestBody(request: value, eventLoop: eventLoop)
}
