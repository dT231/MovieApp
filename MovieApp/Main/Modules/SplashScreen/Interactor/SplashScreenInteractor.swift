//
//  SplashScreenInteractor.swift
//  MovieApp
//
//  Created by Dan Gorb on 23.11.2023.
//

import Combine
import MAServices

final class SplashScreenInteractor {
    private let userInfoService: UserInfoServicing
    private let configService: ConfigurationServicing
    private let moviesService: MoviesServicing
    
    init(
        userInfoService: UserInfoServicing,
        configService: ConfigurationServicing,
        moviesService: MoviesServicing
    ) {
        self.userInfoService = userInfoService
        self.configService = configService
        self.moviesService = moviesService
    }
}

extension SplashScreenInteractor: SplashScreenInteracting {
    func loadUserProfile() -> AnyPublisher<String, Error> {
        userInfoService.loadUserInfo()
    }
    
    func loadAppConfiguration() -> AnyPublisher<Void, Error> {
        configService.loadConfiguration()
    }
    
    func loadMovieGenre() -> AnyPublisher<[String], Error> {
        moviesService.loadGenres()
    }
}
