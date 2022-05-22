//
//  MoviesRepositoryTests.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 28/02/2022.
//

import XCTest
@testable import MovieAppUIKit

class MoviesRepositoryTests: XCTestCase {
    
    private enum MoviesServiceError: Error {
        case someError
    }
    
    let movieDTO: MoviesResponseDTO.MovieDTO = {
        MoviesResponseDTO.MovieDTO(
            id: 1,
            title: "test movie",
            posterPath: nil,
            releaseDate: "2000-01-01"
        )
    }()
    
    func test_whenSucceedsFetchingPopularMovies_shouldReturnMappedResults() {
        // given
        let service = MoviesServiceMock()
        service.expectation = self.expectation(description: "returns mapped results")
        service.moviesResponseDTO = MoviesResponseDTO(page: 1, totalPages: 1, totalResults: 1, movies: [self.movieDTO])
        
        let repository = MoviesRepository(service)
        
        let movie = Movie(id: 1, title: "test movie", posterPath: nil, releaseDate: "2000-01-01")
        let expectedResult = MoviesPage(page: 1, totalPages: 1, movies: [movie])
    
        // when
        var resultMoviesPage: MoviesPage?
        repository.fetchPopularMovies(completion: { result in
            resultMoviesPage = (try? result.get())
        })

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(resultMoviesPage, expectedResult)
    }
    
    func test_whenFailsFetchingPopularMovies_shouldReturnError() {
        // given
        let service = MoviesServiceMock()
        service.expectation = self.expectation(description: "returns error")
        service.error = MoviesServiceError.someError
        
        let repository = MoviesRepository(service)

        // when
        var responseError: MoviesServiceError?
        repository.fetchPopularMovies(completion: { result in
            switch result {
            case .failure(let error):
                responseError = error as? MoviesRepositoryTests.MoviesServiceError
            case .success(_):
                break
            }
        })
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(responseError, MoviesServiceError.someError)
    }
}

final class MoviesServiceMock: MoviesServiceProtocol {
    var expectation: XCTestExpectation?
    var error: Error?
    var moviesResponseDTO = MoviesResponseDTO(page: 1, totalPages: 1, totalResults: 1, movies: [])
    
    func getPopularMovies(_ completion: @escaping (Result<MoviesResponseDTO, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(moviesResponseDTO))
        }
        expectation?.fulfill()
    }
    
    func getTopRatedMovies(_ completion: @escaping (Result<MoviesResponseDTO, Error>) -> Void) {
        
    }
    
    
}
