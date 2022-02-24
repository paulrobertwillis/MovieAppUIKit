//
//  DefaultMoviesService.swift
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

public protocol MoviesService {
    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void)
    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void)
}

final class DefaultMoviesService: Service, MoviesService {
    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        // TODO: Check if this should be injected?
        let request = PopularMoviesRequest()
        
        self.network.perform(request, with: completion)
    }
    
    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        
    }

}
