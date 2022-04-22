//
//  FetchTopRatedMoviesUseCase.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

protocol FetchTopRatedMoviesUseCase {
    func start(completion: @escaping (MoviesPage?) -> Void)
}

final class DefaultFetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase {

    // Should implement UseCase, a default protocol with a start() function that all use cases implement.
    
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }

    func start(completion: @escaping (MoviesPage?) -> Void) {
        self.moviesRepository.fetchTopRatedMovies(completion: { result in
            completion(result)
        })
    }
}
