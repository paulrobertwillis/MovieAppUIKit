//
//  TopRatedMoviesRequest.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

public class TopRatedMoviesRequest: RequestProtocol {
    public var url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=87c18a6eca3e6995e82fab7f60b9a8a7&language=en-US&page=1")!
}
