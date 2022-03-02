//
//  MockMoviesService.swift
//  MovieAppUIKitTests
//
//  Created by Paul on 02/03/2022.
//

import Foundation

//class MockMoviesService: MoviesServiceProtocol {
//    func getPopularMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
//        // TODO: See why dispatch queue makes this pass with 2100-01-01 when it shouldn't
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            let movieDTO = MoviesResponseDTO.MovieDTO(
//                id: 1,
//                title: "test movie",
//                releaseDate: "2100-01-01",
//                posterPath: nil)
//            
//            let moviesResponseDTO = MoviesResponseDTO(
//                page: 1,
//                totalPages: 1,
//                totalResults: 1,
//                movies: [movieDTO])
//            
//            completion(moviesResponseDTO)
//        }
//    }
//    
//    func getTopRatedMovies(_ completion: @escaping (MoviesResponseDTO?) -> Void) {
//        
//    }
//}
