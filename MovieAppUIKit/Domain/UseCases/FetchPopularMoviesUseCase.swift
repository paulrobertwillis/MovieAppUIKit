//
//  FetchPopularMoviesUseCase.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

protocol FetchPopularMoviesUseCase {
    func start(completion: @escaping (MoviesPage?) -> Void)
}

final class DefaultFetchPopularMoviesUseCase: FetchPopularMoviesUseCase {

    // Should implement UseCase, a default protocol with a start() function that all use cases implement.
    
    private let moviesRepository: MoviesRepository
    
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func start(completion: @escaping (MoviesPage?) -> Void) {
        print("inside DefaultFetchPopularMoviesUseCase start()")
        self.moviesRepository.fetchPopularMovies(completion: { result in
            completion(result)
        })
    }
}
