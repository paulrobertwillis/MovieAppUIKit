//
//  NetworkSessionManager.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/04/2022.
//

import Foundation

protocol NetworkSessionManagerProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func getURLSessionDataTask(for request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionDataTask
}

class NetworkSessionManager: NetworkSessionManagerProtocol {
    func getURLSessionDataTask(for request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
