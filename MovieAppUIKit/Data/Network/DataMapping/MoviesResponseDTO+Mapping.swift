//
//  MoviesResponseDTO+Mapping.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

// MARK: - Data Transfer Object

public struct MoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let movies: [MovieDTO]
}

extension MoviesResponseDTO {
    public struct MovieDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case releaseDate = "release_date"
            case posterPath = "poster_path"
        }
        let id: Int
        let title: String?
        let releaseDate: String?
        let posterPath: String?
    }
}

// MARK: - Mappings to Domain

extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        return .init(page: page,
                     totalPages: totalPages,
                     movies: movies.map { $0.toDomain() })
    }
}

extension MoviesResponseDTO.MovieDTO {
    func toDomain() -> Movie {
        return .init(id: id,
                     title: title,
                     posterPath: posterPath,
                     releaseDate: releaseDate)
    }
}
