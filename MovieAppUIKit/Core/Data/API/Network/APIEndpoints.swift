//
//  APIEndpoints.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/04/2022.
//

import Foundation

struct APIEndpoints {
    
    static func getMovies(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {
        Endpoint(
            path: "3/search/movie/",
            method: .get,
            queryItemsEncodable: moviesRequestDTO
        )
    }
    
    static func getMoviePoster(path: String, width: Int) -> Endpoint<Data> {
        // TODO: Have w500 dynamically replaced based on the width being passed into this function
        Endpoint(
            path: "t/p/w500\(path)",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
}
