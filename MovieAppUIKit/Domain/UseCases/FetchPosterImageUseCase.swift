//
//  FetchPosterImageUseCase.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

protocol FetchPosterImageUseCaseProtocol {
    func start(completion: @escaping (Data?) -> Void)
}

class FetchPosterImageUseCase: FetchPosterImageUseCaseProtocol {

    // Should implement UseCase, a default protocol with a start() function that all use cases implement.
    
    private let posterImageRepository: PosterImageRepositoryProtocol
    
    init(posterImageRepository: PosterImageRepositoryProtocol) {
        self.posterImageRepository = posterImageRepository
    }

    func start(completion: @escaping (Data?) -> Void) {
//        self.posterImageRepository.fetchImage(with: <#T##String#>, width: <#T##Int#>, completion: { result in
//            completion(result)
//        })
    }
}
