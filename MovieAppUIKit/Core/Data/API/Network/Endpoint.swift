//
//  Endpoint.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/04/2022.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
}

struct Endpoint<R>: ResponseRequestable {
    
    typealias Response = R
    
    let path: String
    let method: HTTPMethodType
    let queryItemsEncodable: Encodable?
    let queryItems: [String: String]
    let responseDecoder: ResponseDecoderProtocol
    
    init(
        path: String,
        method: HTTPMethodType,
        queryItemsEncodable: Encodable? = nil,
        queryItems: [String: String] = [:],
        responseDecoder: ResponseDecoderProtocol = JSONResponseDecoder()
    ) {
        self.path = path
        self.method = method
        self.queryItemsEncodable = queryItemsEncodable
        self.queryItems = queryItems
        self.responseDecoder = responseDecoder
    }
}

// MARK: - Requestable
protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var queryItemsEncodable: Encodable? { get }
    var queryItems: [String: String] { get }
    
    func urlRequest(with networkConfig: NetworkConfigProtocol) throws -> URLRequest
}

extension Requestable {
    func url(with config: NetworkConfigProtocol) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = config.baseURL
        components.path = "/" + self.path
        components.queryItems = try self.queryItemsEncodable?.toDictionary()?.toURLQueryItem()
    
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
    
    func urlRequest(with networkConfig: NetworkConfigProtocol) throws -> URLRequest {
        let url = try self.url(with: networkConfig)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}

// MARK: - ResponseRequestable
protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoderProtocol { get }
}

private extension Encodable {
    func toDictionary() throws -> [String: String]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: String]
    }
}

private extension Dictionary where Key == String {
    func toURLQueryItem() -> [URLQueryItem]? {
        var urlQueryItems = [URLQueryItem]()
        
        for (key, value) in self {
            urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        return urlQueryItems
    }
}
