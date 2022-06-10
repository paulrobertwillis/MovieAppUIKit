//
//  MoviesHomepageViewModelTests.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 28/02/2022.
//

import XCTest
@testable import MovieAppUIKit

class MoviesHomepageViewModelTests: XCTestCase {
    //    var sut: MoviesHomepageViewModel!
    
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
    
    /*
     
     // When tap Top Rated button, should fetch a single page of Top Rated movies.
     
     // When tap Popular button, should fetch a single page of Popular movies.
     
     // When tap fetch buttons, should have a list of movies in movies array ready for presentation
     
     // When tap on movie, should navigate to MovieDetailsViewController
          
     */
    
    func testMoviesHomepageViewModel_whenTapMoviesListeItem_shouldNavigateToMovieDetailsView() {
        // given
        let sut = MoviesHomepageViewModel(fetchPopularMoviesUseCase: FetchPopularMoviesUseCaseMock(), fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCaseStub(), delegate: MoviesHomepageViewModelDelegateStub())
        
        
        // when
        
        
        // then
        
    }
    
//    func testMoviesHomepageViewModel_whenSearchPopularMovies_shouldStoreFirstPageOfResultsAsVariable() {
//        // given
//        let mock = FetchPopularMoviesUseCaseMock()
//        mock.page = MoviesPage.stub()
//        let sut = MoviesHomepageViewModel(fetchPopularMoviesUseCase: mock, fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCaseStub(), delegate: MoviesHomepageViewModelDelegateStub())
//
//        // when
//        sut.didSearchPopularMovies()
//        let expectedMovies = mock.page.movies.compactMap(MoviesListItemViewModel.init)
//
//        // then
//        XCTAssertEqual(sut.movies, expectedMovies)
//    }
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

final class FetchTopRatedMoviesUseCaseStub: FetchTopRatedMoviesUseCaseProtocol {
    var page = MoviesPage(page: 0, totalPages: 0, movies: [])
    
    func start(completion: @escaping (Result<MoviesPage, Error>) -> Void) {
        completion(.success(page))
    }
}

final class MoviesHomepageViewModelDelegateStub: MoviesHomepageViewModelDelegate {
    func refreshList() {
        // do nothing
    }
}

