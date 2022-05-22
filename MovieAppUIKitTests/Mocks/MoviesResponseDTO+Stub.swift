//
//  MoviesResponseDTO+Stub.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 22/05/2022.
//

import Foundation

extension MoviesResponseDTO {
    static func stub(
        page: Int = 1,
        totalPages: Int = 1,
        totalResults: Int = 2,
        movies: [MovieDTO] = [MovieDTO].stub()
    ) -> Self {
        MoviesResponseDTO(
            page: page,
            totalPages: totalPages,
            totalResults: totalResults,
            movies: movies
        )
    }
}
