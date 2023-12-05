//
//  ResponseError.swift
//  MADomainEntites
//
//  Created by Dan Gorb on 05.12.2023.
//

import Foundation

public enum ResponseError: Error {
    case noConnection
    case request(error: Error, url: URL?)
    case mapping(response: HTTPURLResponse, error: Error, stringData: String)
    case response(error: ResponseErrorType, response: HTTPURLResponse, statusCode: Int, httpMethod: String?)
    case noHTTPResponse(response: URLResponse?)
    
    public var statusCode: Int? {
        switch self {
        case let .request(error, _):
            let nsError = error as NSError
            return nsError.code
            
        case let .response(_, _, statusCode, _):
            return statusCode
            
        case let .mapping(response: _, error, _):
            let nsError = error as NSError
            return nsError.code
            
        default: return nil
        }
    }
}

public extension ResponseError {
    enum ResponseErrorType {
        case raw(Data)
        case base(BaseError)

        public var base: BaseError? {
            switch self {
            case let .base(error):
                return error
            default:
                return nil
            }
        }
    }
}

public extension Error {
    var asResponseError: ResponseError? {
        return self as? ResponseError
    }
}
