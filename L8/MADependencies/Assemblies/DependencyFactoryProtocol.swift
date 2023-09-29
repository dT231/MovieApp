//
//  DependencyFactoryProtocol.swift
//  Dependencies
//
//  Created by Dan Gorb on 15.09.2023.
//

import Foundation

public typealias DependencyFactoryProtocol = NetworkFactoryProtocol

public protocol NetworkFactoryProtocol {
    var stub: String { get }
}
