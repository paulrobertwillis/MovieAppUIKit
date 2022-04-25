//
//  PosterImageRepository.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

protocol PosterImageRepositoryProtocol {
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    
    func fetchImage(with imagePath: String, width: Int, completion: @escaping CompletionHandler) -> URLSessionDataTask?
}

class PosterImageRepository {
    private let dataTransferService: DataTransferServiceProtocol
    
    init(dataTransferService: DataTransferServiceProtocol) {
        self.dataTransferService = dataTransferService
    }
}

extension PosterImageRepository: PosterImageRepositoryProtocol {

    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        let endpoint = APIEndpoints.getMoviePoster(path: imagePath, width: width)
        
        let sessionDataTask = self.dataTransferService.request(with: endpoint) { (result: Result<Data, Error>) in
            
            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        }
        
        return sessionDataTask
    }
}
