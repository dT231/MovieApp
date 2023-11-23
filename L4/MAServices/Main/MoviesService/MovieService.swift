//
//  MovieService.swift
//  MAServices
//
//  Created by Dan Gorb on 23.11.2023.
//

import Combine

final public class MovieService {
    
}

extension MovieService: MoviesServicing {
    public func loadGenres() -> AnyPublisher<[String], Error> {
        Result.Publisher(["GenreStub1", "GenreStub2"]).eraseToAnyPublisher()
    }
}
