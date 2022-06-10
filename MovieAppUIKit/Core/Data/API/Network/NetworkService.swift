//
//  NetworkService.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

protocol NetworkServiceProtocol {
    typealias CompletionHandler = (Result<Data?, Error>) -> Void
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> URLSessionDataTask?
}

class NetworkService {
    
    // MARK: - Private Properties
    
    private let config: NetworkConfigProtocol
    private let sessionManager: NetworkSessionManagerProtocol
    
    // MARK: - Lifecycle
    
    init(
        config: NetworkConfigProtocol,
        sessionManager: NetworkSessionManagerProtocol
    ) {
        self.config = config
        self.sessionManager = sessionManager
    }
    
    // MARK: - Helpers
    
    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionDataTask {
        let sessionDataTask = self.sessionManager.getURLSessionDataTask(for: request) { data, urlResponse, requestError in
            if let requestError = requestError {
                completion(.failure(requestError))
            } else {
                completion(.success(data))
            }
        }
        
        return sessionDataTask
    }
}

// MARK: - NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> URLSessionDataTask? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    private func performRequest(endpoint: Endpoint<Any>, completion: @escaping CompletionHandler) {
//
//        let appConfiguration = AppConfiguration()
//        let apiDataNetworkConfig = APIDataNetworkConfig(baseURL: appConfiguration.apiBaseURL,
//                                                        queryParameters: ["api_key": appConfiguration.apiKey])
//
////        guard let url = endpoint.url
//
//
//
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = apiDataNetworkConfig.baseURL
////        components.path =
//
//
////        let sessionDataTask = self.sessionManager.getURLSessionDataTask(for: <#T##URLRequest#>, completion: <#T##(Data?, URLResponse?, Error?) -> Void#>)
//
////        let session = URLSession.shared
////        let url = URL(string: "")!
////
////        let task = session.dataTask(with: url, completionHandler: { data, response, error in
////            print(response ?? "")
////
////            if error != nil {
////                print(error ?? "")
////                return
////            }
////
////            do {
////                let json = try JSONDecoder().decode([MoviesResponseDTO].self, from: data!)
////                print(json)
////            } catch {
////                print("Error during JSON decoding")
////            }
////        })
////        task.resume()
//    }
}
