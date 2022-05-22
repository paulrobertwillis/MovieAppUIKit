//
//  Movie+Stub.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 22/05/2022.
//

import Foundation

extension Movie {
    static func stub(
        id: Int = 1,
        title: String? = "title1",
        posterPath: String? = "/1",
        releaseDate: String? = "1900-01-01"
    ) -> Self {
        Movie(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate
        )
    }
}

extension Array where Element == Movie {
    static func stub() -> Self {
        let movie1 = Movie(id: 1, title: "title1", posterPath: "/1", releaseDate: "1900-01-01")
        let movie2 = Movie(id: 2, title: "title2", posterPath: "/2", releaseDate: "1900-01-02")
    
        return [movie1, movie2]
    }
}
