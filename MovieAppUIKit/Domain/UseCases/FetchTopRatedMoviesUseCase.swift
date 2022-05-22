//
//  FetchTopRatedMoviesUseCase.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

protocol FetchTopRatedMoviesUseCaseProtocol {
    func start(completion: @escaping (Result<MoviesPage, Error>) -> Void)
}

class FetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCaseProtocol {
    
    // Should implement UseCase, a default protocol with a start() function that all use cases implement.
    
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    func start(completion: @escaping (Result<MoviesPage, Error>) -> Void) {
        self.moviesRepository.fetchTopRatedMovies(completion: { result in
            switch result {
            case .success(let page):
                completion(.success(page))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
