//
//  MoviesRepository.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func fetchMoviesPage(completion: @escaping (Result<MoviesPage, Error>) -> Void)
    
    func fetchPopularMovies(completion: @escaping (Result<MoviesPage, Error>) -> Void)
    func fetchTopRatedMovies(completion: @escaping (Result<MoviesPage, Error>) -> Void)
}

class MoviesRepository: MoviesRepositoryProtocol {
    private let service: MoviesServiceProtocol
    
    public init(_ service: MoviesServiceProtocol) {
        self.service = service
    }
    
    public func fetchMoviesPage(completion: @escaping (Result<MoviesPage, Error>) -> Void) {
        
    }
    
    public func fetchPopularMovies(completion: @escaping (Result<MoviesPage, Error>) -> Void) {
//        TODO: Use this to genericise the two fetch functions. Can use e.g. service.getMovies(with: request)?
//        let request = PopularMoviesRequest()
        
        self.service.getPopularMovies { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchTopRatedMovies(completion: @escaping (Result<MoviesPage, Error>) -> Void) {
        self.service.getTopRatedMovies { result in
            self.service.getTopRatedMovies { result in
                switch result {
                case .success(let responseDTO):
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
