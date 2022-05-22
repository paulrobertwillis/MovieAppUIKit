//
//  PosterImageService.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

public protocol PosterImageServiceProtocol {
    func getPosterImage(_ completion: @escaping (Data?) -> Void)
}

class PosterImageService: Service, PosterImageServiceProtocol {
    func getPosterImage(_ completion: @escaping (Data?) -> Void) {
        // TODO: Check if this should be injected?
//        let request = PopularMoviesRequest()
//        self.network.perform(request, with: completion)
    }
}
