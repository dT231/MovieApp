//
//  MoviesServicing.swift
//  MAServices
//
//  Created by Dan Gorb on 23.11.2023.
//

import Combine

public protocol MoviesServicing {
    func loadGenres() -> AnyPublisher<Void, Error>
}
