//
//  MoviesRepository.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

protocol MoviesRepository {
    func fetchPopularMovies(completion: @escaping (MoviesPage?) -> Void)
    func fetchTopRatedMovies(completion: @escaping (MoviesPage?) -> Void)
}

final class DefaultMoviesRepository: MoviesRepository {
    private let service: MoviesService
    
    public init(_ service: MoviesService) {
        self.service = service
    }
    
    public func fetchPopularMovies(completion: @escaping (MoviesPage?) -> Void) {
//        TODO: Use this to genericise the two fetch functions. Can use e.g. service.getMovies(with: request)?
//        let request = PopularMoviesRequest()
        
        print("inside DefaultMoviesRepository fetchPopularMovies()")
        self.service.getPopularMovies { result in
            completion(result?.toDomain())
        }
    }
    
    public func fetchTopRatedMovies(completion: @escaping (MoviesPage?) -> Void) {
        self.service.getTopRatedMovies { result in
            self.service.getTopRatedMovies { result in
                completion(result?.toDomain())
            }
        }
    }
}
