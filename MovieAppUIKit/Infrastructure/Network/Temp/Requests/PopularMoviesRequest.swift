//
//  PopularMoviesRequest.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

public class PopularMoviesRequest: NetworkRequestProtocol {
    
    public var url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=87c18a6eca3e6995e82fab7f60b9a8a7")!
}
