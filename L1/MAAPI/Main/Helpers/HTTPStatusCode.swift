//
//  HTTPStatusCode.swift
//  MAAPI
//
//  Created by Dan Gorb on 05.12.2023.
//

import Foundation

public enum HTTPStatusCode: Int {
    case ok = 200
    case created = 201
    case okNoContent = 204
    case okMultiStatus = 207
    case notAuthorized = 401
    case forbidden = 403
    case badRequest = 400
    case unprocessableEntity = 422
    case tooManyRequests = 429
    case notFound = 404
}
