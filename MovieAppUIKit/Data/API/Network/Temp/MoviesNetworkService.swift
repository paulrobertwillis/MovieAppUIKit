//
//  MoviesNetworkService.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

public enum NetworkError: Error {
    case failedDecode
}

public protocol MoviesNetworkServiceProtocol {
    func perform<RequestType: RequestProtocol>(_ request: RequestType, with completion: @escaping (Result<MoviesResponseDTO, Error>) -> Void)
}

class MoviesNetworkService: MoviesNetworkServiceProtocol {
    // TODO: Genericise this service to perform requests and decode the results for T, not just for MoviesResponseDTO
    public func perform<RequestType: RequestProtocol>(_ request: RequestType, with completion: @escaping (Result<MoviesResponseDTO, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request.url) { [weak self] (data, response, error) -> Void in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            } else {
                guard let value = self?.decode(data) else { return completion(.failure(NetworkError.failedDecode))}
                DispatchQueue.main.async { completion(.success(value)) }
            }
        }
        task.resume()
    }
    
    private func decode(_ data: Data?) -> MoviesResponseDTO? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(MoviesResponseDTO.self, from: data)
        return wrapper
    }
}
