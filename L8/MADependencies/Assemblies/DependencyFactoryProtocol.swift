//
//  DependencyFactoryProtocol.swift
//  Dependencies
//
//  Created by Dan Gorb on 15.09.2023.
//

import Foundation
import MAServices

public typealias DependencyFactoryProtocol = NetworkFactoryProtocol & ServiceFactoryProtocol

public protocol NetworkFactoryProtocol {
    var stub: String { get }
}

public protocol ServiceFactoryProtocol {
    var userInfoServiceProtocol: UserInfoServicing { get }
    var configurationService: ConfigurationServicing { get }
    var MoviesService: MoviesServicing { get }
}
