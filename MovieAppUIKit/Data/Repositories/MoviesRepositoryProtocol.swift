//
//  MoviesRepository.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func fetchPopularMovies(completion: @escaping (MoviesPage?) -> Void)
    func fetchTopRatedMovies(completion: @escaping (MoviesPage?) -> Void)
}

class MoviesRepository: MoviesRepositoryProtocol {
    private let service: MoviesServiceProtocol
    
    public init(_ service: MoviesServiceProtocol) {
        self.service = service
    }
    
    public func fetchPopularMovies(completion: @escaping (MoviesPage?) -> Void) {
//        TODO: Use this to genericise the two fetch functions. Can use e.g. service.getMovies(with: request)?
//        let request = PopularMoviesRequest()
        
        print("inside MoviesRepository fetchPopularMovies()")
        self.service.getPopularMovies { result in
            completion(result?.toDomain())
        }
    }
    
    public func fetchTopRatedMovies(completion: @escaping (MoviesPage?) -> Void) {
        print("inside MoviesRepository fetchPopularMovies()")
        self.service.getTopRatedMovies { result in
            self.service.getTopRatedMovies { result in
                completion(result?.toDomain())
            }
        }
    }
}
