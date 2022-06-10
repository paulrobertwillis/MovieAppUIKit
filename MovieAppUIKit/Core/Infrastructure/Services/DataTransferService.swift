//
//  DataTransferService.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/04/2022.
//

import Foundation

protocol DataTransferServiceProtocol {
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> URLSessionDataTask? where E.Response == T
}

class DataTransferService {
    private let networkService: NetworkServiceProtocol
    
    init(with networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}



// MARK: - DataTransferServiceProtocol
extension DataTransferService: DataTransferServiceProtocol {
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> URLSessionDataTask? where E.Response == T {
        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, Error> = self.decode(data: data, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoderProtocol) -> Result<T, Error> {
        do {
            let result: T = try decoder.decode(data!)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

}
