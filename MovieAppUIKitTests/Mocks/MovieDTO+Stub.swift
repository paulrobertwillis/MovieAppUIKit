//
//  MovieDTO+Stub.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 22/05/2022.
//

import Foundation

extension MoviesResponseDTO.MovieDTO {
    static func stub(
        id: Int = 1,
        title: String? = "title1",
        posterPath: String? = "/1",
        releaseDate: String? = "1900-01-01"
    ) -> Self {
        MoviesResponseDTO.MovieDTO(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate
        )
    }
}

extension Array where Element == MoviesResponseDTO.MovieDTO {
    static func stub() -> Self {
        let dto1 = MoviesResponseDTO.MovieDTO(id: 1, title: "title1", posterPath: "/1", releaseDate: "1900-01-01")
        let dto2 = MoviesResponseDTO.MovieDTO(id: 2, title: "title2", posterPath: "/2", releaseDate: "1900-01-02")
    
        return [dto1, dto2]
    }
}
