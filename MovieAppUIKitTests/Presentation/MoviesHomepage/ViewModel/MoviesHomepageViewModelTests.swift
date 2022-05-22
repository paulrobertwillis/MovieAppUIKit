//
//  MoviesHomepageViewModelTests.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 28/02/2022.
//

import XCTest
@testable import MovieAppUIKit

class MoviesHomepageViewModelTests: XCTestCase {
    var sut: MoviesHomepageViewModel!
    
    var moviesPages: [MoviesPage] = {
        let page1 = MoviesPage(page: 1, totalPages: 2, movies: [
            Movie.stub(id: 1, title: "title1", posterPath: "/1", releaseDate: nil),
            Movie.stub(id: 2, title: "title2", posterPath: "/2", releaseDate: nil)])
        let page2 = MoviesPage(page: 2, totalPages: 2, movies: [
            Movie.stub(id: 3, title: "title3", posterPath: "/3", releaseDate: nil)])
        return [page1, page2]
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

final class FetchPopularMoviesUseCaseMock: FetchPopularMoviesUseCaseProtocol {
    var error: Error?
    var page = MoviesPage(page: 0, totalPages: 0, movies: [])
    
    func start(completion: @escaping (Result<MoviesPage, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(page))
        }
    }
}
