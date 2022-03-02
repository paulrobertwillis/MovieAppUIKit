//
//  MoviesService.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

class Service {
    public let network: NetworkServiceProtocol
    
    public required init(network: NetworkServiceProtocol) {
        self.network = network
    }
}

public protocol MoviesServiceProtocol {
    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void)
    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void)
}

final class MoviesService: Service, MoviesServiceProtocol {
    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        print("inside DefaultMoviesService getPopularMovies()")
        
        // TODO: Check if this should be injected?
        let request = PopularMoviesRequest()
        self.network.perform(request, with: completion)
    }
    
    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        print("inside DefaultMoviesService getTopRatedMovies()")

        let request = TopRatedMoviesRequest()
        self.network.perform(request, with: completion)
    }
}
