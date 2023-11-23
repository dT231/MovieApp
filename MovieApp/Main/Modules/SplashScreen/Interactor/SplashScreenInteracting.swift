//
//  SplashScreenInteracting.swift
//  MovieApp
//
//  Created by Dan Gorb on 23.11.2023.
//

import Foundation
import Combine

protocol SplashScreenInteracting {
    func loadUserProfile() -> AnyPublisher<String, Error>
    func loadAppConfiguration() -> AnyPublisher<Void, Error>
    func loadMovieGenre() -> AnyPublisher<[String], Error>
}
