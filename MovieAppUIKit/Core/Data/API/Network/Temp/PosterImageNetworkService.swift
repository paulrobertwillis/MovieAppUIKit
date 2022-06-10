//
//  PosterImageNetworkService.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

public protocol PosterImageNetworkServiceProtocol {
    func perform<RequestType: RequestProtocol>(_ request: RequestType, with completion: @escaping (Data?) -> Void)
}

class PosterImageNetworkService: PosterImageNetworkServiceProtocol {
    // TODO: Genericise this service to perform requests and decode the results for T, not just for Data
    public func perform<RequestType: RequestProtocol>(_ request: RequestType, with completion: @escaping (Data?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request.url) { [weak self] (data, response, error) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
    
    private func decode(_ data: Data) -> Data? {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(Data.self, from: data)
        return wrapper
    }
}
