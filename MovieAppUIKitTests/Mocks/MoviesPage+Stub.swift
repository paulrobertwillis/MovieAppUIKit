//
//  MoviesPage+Stub.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 22/05/2022.
//

import Foundation

extension MoviesPage {
    static func stub(
        page: Int = 1,
        totalPages: Int = 1,
        movies: [Movie] = [Movie].stub()
    ) -> Self {
        MoviesPage(page: page, totalPages: totalPages, movies: movies)
    }
}
