//
//  MoviesService.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

public protocol MoviesServiceProtocol {
    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void)
    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void)
}

class MoviesService: Service, MoviesServiceProtocol {
    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        // TODO: Check if this should be injected?
        let request = PopularMoviesRequest()
        self.network.perform(request, with: completion)
    }
    
    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        let request = TopRatedMoviesRequest()
        self.network.perform(request, with: completion)
    }
}
