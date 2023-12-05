//
//  BaseApiError.swift
//  MADomainEntites
//
//  Created by Dan Gorb on 05.12.2023.
//

import Foundation

/// Main API error type. Perfectly, all API errors should have this format
public struct BaseError: Decodable, Error {
    /// List of messages, that describe errors
    public let errorMessage: [Message]
    
    /// Additional information about error
    public let data: [String : AnyDecodableValue]?
}

public extension BaseError {
    /// Base error message, that describes error
    struct Message: Decodable {
        public let field: String
        public let message: String
        public let humanMessage: String
        public let type: String?
    }
}
