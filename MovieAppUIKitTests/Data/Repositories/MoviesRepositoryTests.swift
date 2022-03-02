//
//  MoviesRepositoryTests.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 28/02/2022.
//

import XCTest
@testable import MovieAppUIKit

class MoviesRepositoryTests: XCTestCase {
    
    func test_whenFetchingPopularMovies_shouldReturnMappedResults() {
        let service = MockMoviesService()
        let repository = MoviesRepository(service)
        
        let movie = Movie(
            id: 1,
            title: "test movie",
            posterPath: nil,
            releaseDate: "2000-01-01")
        
        let expectedResult = MoviesPage(page: 1, totalPages: 1, movies: [movie])

        repository.fetchPopularMovies(completion: { result in
            XCTAssertEqual(result, expectedResult)
        })
    }
}

class MockMoviesService: MoviesServiceProtocol {
    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let movieDTO = MoviesResponseDTO.MovieDTO(
                id: 1,
                title: "test movie",
                releaseDate: "2100-01-01",
                posterPath: nil)
            
            let moviesResponseDTO = MoviesResponseDTO(
                page: 1,
                totalPages: 1,
                totalResults: 1,
                movies: [movieDTO])
            
            completion(moviesResponseDTO)
        }
    }
    
    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
        
    }
    
    
}
