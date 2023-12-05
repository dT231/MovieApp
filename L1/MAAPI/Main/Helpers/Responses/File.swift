//
//  File.swift
//  MAAPI
//
//  Created by Dan Gorb on 05.12.2023.
//

import Foundation
// Wrapper for decoding a value of unknown type.
///
/// Provides a way for type safe decoding without using casts.
///
/// For dictionary with different types of values can be used
/// like this `[String: AnyDecodableValue]` instead of `[String: Any]`.
/// This way you don't need to implement custom `init(from decoder:)`
/// and you don't need to use type casts when using values from `[String: Any]`.
///
/// Example:
///
///     let data = """
///         {
///             "key1": 1,
///             "key2": "2"
///         }
///     """.data(using: .utf8)!
///
///     let decoded = try! JSONDecoder()
///         .decode([String: AnyDecodableValue].self, from: data)
///
///     print(decoded)
///
/// `decoded` will be equal to
///
///     [
///         "key1" : .int(1),
///         "key2" : .string("2")
///     ]
///
///  Support nested arrays and dictionaries not needed yet
///
public enum AnyDecodableValue: Decodable {
    case bool(Bool)
    case int(Int)
    case double(Double)
    case string(String)
    case null
    case unsupported
    
    public enum CodingKeys: CodingKey {
        case bool
        case int
        case double
        case string
        case null
        case unsupported
    }
    
    public init(from decoder: Decoder) throws {
        func decodeSpecific<T: Decodable>() -> T? {
            try? decoder.singleValueContainer().decode(T.self)
        }
        
        if (try? decoder.singleValueContainer().decodeNil()) == true {
            self = .null
        }
        
        if let value: AnyDecodableValue =
            decodeSpecific().map({ .bool($0) }) ??
            decodeSpecific().map({ .int($0) }) ??
            decodeSpecific().map({ .double($0) }) ??
            decodeSpecific().map({ .string($0) })
        {
            self = value
        } else {
            print("Unable to decode value at coding path: \(decoder.codingPath.debugDescription)")
            self = .unsupported
        }
    }
}
