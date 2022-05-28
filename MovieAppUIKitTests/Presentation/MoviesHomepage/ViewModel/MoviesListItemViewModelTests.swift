//
//  MoviesListItemViewModelTests.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 28/02/2022.
//

import XCTest
@testable import MovieAppUIKit

class MoviesListItemViewModelTests: XCTestCase {

    // instantiates with movie
    // title var is equal to movie title
    // release date is equal to movie release date
    // poster path is equal to movie poster path
    
    var movie: Movie!
    var sut: MoviesListItemViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.movie = Movie.stub()
        self.sut = MoviesListItemViewModel(movie)
    }
    
    override func tearDown() {
        self.movie = nil
        self.sut = nil
        
        super.tearDown()
    }
    
    
    func testMoviesListItemViewModel_CanBeInitialised() {
        // then
        XCTAssertNotNil(self.sut)
    }
    
    func testMoviesListItemViewModel_whenMovieTitleIsNotNil_thenVMTitleEqualsMovieTitle() {
        // then
        XCTAssertEqual(self.movie.title, self.sut.title)
    }
    
    func testMoviesListItemViewModel_whenMovieTitleIsNil_thenVMTitleIsEmptyString() {
        // given
        let movie = Movie.stub(id: 1, title: nil, posterPath: "/1", releaseDate: "1900-01-01")
        
        // when
        let sut = MoviesListItemViewModel(movie)
        
        // then
        XCTAssertEqual(sut.title, "")
    }
    
    func testMoviesListItemViewModel_whenInstantiated_VMTitleEqualsMovieTitle() {
        // then
        XCTAssertEqual(self.movie.posterPath, self.sut.posterImagePath)
    }
    
    func testMoviesListItemViewModel_whenMovieReleaseDateNotNil_thenVMReleaseDateInterpolatesMovieReleaseDate() {
        // when
        let sutReleaseDateString = "Release date: \(self.movie.releaseDate!)"

        // then
        XCTAssertEqual(self.sut.releaseDate, sutReleaseDateString)
    }
    
    func testMoviesListItemViewModel_whenMovieReleaseDateIsNil_thenVMReleaseDateIsDefaultString() {
        // given
        let movie = Movie.stub(id: 1, title: "movie1", posterPath: "/1", releaseDate: nil)
        
        // when
        let sut = MoviesListItemViewModel(movie)
        let defaultString = "To be announced..."
        
        // then
        XCTAssertEqual(sut.releaseDate, defaultString)
    }
}
