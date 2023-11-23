//
//  DependencyFactory.swift
//  MADependencies
//
//  Created by Dan Gorb on 23.11.2023.
//

import MAServices

public final class DependencyFactory: DependencyFactoryProtocol {
    public var stub: String = ""
    
    public lazy var userInfoServiceProtocol: UserInfoServicing = 
    
    public lazy var configurationService: ConfigurationServicing
    
    public lazy var MoviesService: MoviesServicing
}
