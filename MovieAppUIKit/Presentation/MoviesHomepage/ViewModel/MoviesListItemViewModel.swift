//
//  MoviesListItemViewModel.swift
//  MovieAppUIKit
//
//  Created by Paul on 25/02/2022.
//

import Foundation

public struct MoviesListItemViewModel {
    
    let title: String
    let releaseDate: String
    let posterPath: String?
    
    public init(_ movie: Movie) {
        self.title = movie.title ?? ""
        self.posterPath = movie.posterPath
        
        if let releaseDate = movie.releaseDate {
            self.releaseDate = "Release date: \(releaseDate)"
        } else {
            self.releaseDate = "To be announced..."
        }
    }
}

