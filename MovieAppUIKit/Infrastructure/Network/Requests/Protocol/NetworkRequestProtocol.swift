//
//  NetworkRequestProtocol.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

public protocol NetworkRequestProtocol {
    // TODO: Update to include components for URL, including URLQueryItem from FilmicMovieDatabase
    
    var url: URL { get set }
}
