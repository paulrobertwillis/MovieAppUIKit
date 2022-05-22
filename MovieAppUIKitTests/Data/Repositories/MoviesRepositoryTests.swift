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
    
    let movie: Movie = {
        Movie(
            id: 1,
            title: "test movie",
            posterPath: nil,
            releaseDate: "2000-01-01"
        )
    }()
    
    var service: MoviesServiceMock!
    var sut: MoviesRepository!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        self.service = MoviesServiceMock()
        self.sut = MoviesRepository(self.service)
    }
    
    override func tearDown() {
        self.service = nil
        self.sut = nil
        
        super.tearDown()
    }
        
    // MARK: - Tests
    
    func test_whenSucceedsFetchingPopularMovies_shouldReturnMappedResults() {
        // given
        self.service.moviesResponseDTO = MoviesResponseDTO(page: 1, totalPages: 1, totalResults: 1, movies: [self.movieDTO])
        let expectedResult = MoviesPage(page: 1, totalPages: 1, movies: [self.movie])
    
        // when
        var resultMoviesPage: MoviesPage?
        self.sut.fetchPopularMovies(completion: { result in
            resultMoviesPage = (try? result.get())
        })

        // then
        XCTAssertEqual(resultMoviesPage, expectedResult)
    }
    
    func test_whenFailsFetchingPopularMovies_shouldReturnError() {
        // given
        self.service.expectation = self.expectation(description: "returns error for popular movies")
        self.service.error = MoviesServiceError.someError
        
        // when
        var responseError: MoviesServiceError?
        self.sut.fetchPopularMovies(completion: { result in
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
    
//    func test_whenSucceedsFetchingTopRatedMovies_shouldReturnMappedResults() {
//        // given
//        self.service.expectation = self.expectation(description: "returns mapped results for top-rated movies")
//        self.service.moviesResponseDTO = MoviesResponseDTO(page: 1, totalPages: 1, totalResults: 1, movies: [self.movieDTO])
//
//        let movie = Movie(id: 1, title: "test movie", posterPath: nil, releaseDate: "2000-01-01")
//        let expectedResult = MoviesPage(page: 1, totalPages: 1, movies: [movie])
//
//        // when
//        var resultMoviesPage: MoviesPage?
//        self.sut.fetchTopRatedMovies(completion: { result in
//            resultMoviesPage = (try? result.get())
//        })
//
//        // then
//        waitForExpectations(timeout: 5, handler: nil)
//        XCTAssertEqual(resultMoviesPage, expectedResult)
//    }
}

final class MoviesServiceMock: MoviesServiceProtocol {
    var expectation: XCTestExpectation?
    var error: Error?
    var moviesResponseDTO = MoviesResponseDTO(page: 1, totalPages: 1, totalResults: 1, movies: [])
    
    func getPopularMovies(_ completion: @escaping (Result<MoviesResponseDTO, Error>) -> Void) {
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.moviesResponseDTO))
        }
        self.expectation?.fulfill()
    }
    
    func getTopRatedMovies(_ completion: @escaping (Result<MoviesResponseDTO, Error>) -> Void) {
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(self.moviesResponseDTO))
        }
        self.expectation?.fulfill()
    }
}
