//
//  SplashScreenInteracting.swift
//  MovieApp
//
//  Created by Dan Gorb on 23.11.2023.
//

import Foundation
import Combine

protocol SplashScreenInteracting {
    func loadUserProfile() -> AnyPublisher<Void, Error>
    func loadAppConfiguration() -> AnyPublisher<Void, Error>
    func loadMovieGenre() -> AnyPublisher<Void, Error>
}
