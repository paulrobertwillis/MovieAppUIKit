//
//  Movie.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

struct Movie: Equatable, Identifiable {
    let id: Int
    let title: String?
    let posterPath: String?
    let releaseDate: String?
}

struct MoviesPage: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [Movie]
}
