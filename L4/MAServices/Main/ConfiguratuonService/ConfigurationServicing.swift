//
//  ConfigurationService.swift
//  MovieApp
//
//  Created by Dan Gorb on 11.10.2023.
//

import Combine
import MADomainEntites

public protocol ConfigurationServicing {
    func loadConfiguration() -> AnyPublisher<Void, Error>
    func sharedConfig() -> AppConfig?
}
