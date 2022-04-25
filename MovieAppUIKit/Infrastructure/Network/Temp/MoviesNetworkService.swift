//
//  MoviesNetworkService.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/02/2022.
//

import Foundation

public protocol MoviesNetworkServiceProtocol {
    func perform<RequestType: NetworkRequestProtocol>(_ request: RequestType, with completion: @escaping (MoviesResponseDTO?) -> Void)
}

class MoviesNetworkService: MoviesNetworkServiceProtocol {
    // TODO: Genericise this service to perform requests and decode the results for T, not just for MoviesResponseDTO
    public func perform<RequestType: NetworkRequestProtocol>(_ request: RequestType, with completion: @escaping (MoviesResponseDTO?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request.url) { [weak self] (data, response, error) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
    
    private func decode(_ data: Data) -> MoviesResponseDTO? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(MoviesResponseDTO.self, from: data)
        return wrapper
    }
}
