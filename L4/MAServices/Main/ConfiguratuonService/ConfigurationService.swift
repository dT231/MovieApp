//
//  ConfigurationService.swift
//  MAServices
//
//  Created by Dan Gorb on 23.11.2023.
//

import Combine
import MADomainEntites

final public class ConfigurationService {
    private var config: AppConfig?
}

extension ConfigurationService: ConfigurationServicing {
    public func loadConfiguration() -> AnyPublisher<Void, Error> {
        Result.Publisher(()).eraseToAnyPublisher()
    }
    
    public func sharedConfig() -> AppConfig? {
        config
    }
}
