//
//  NetworkConfig.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/04/2022.
//

import Foundation

protocol NetworkConfigProtocol {
    var baseURL: String { get }
    var queryParameters: [String: String] { get }
}

public struct APIDataNetworkConfig: NetworkConfigProtocol {
    let baseURL: String
    let queryParameters: [String : String]
    
    public init(
        baseURL: String,
        queryParameters: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.queryParameters = queryParameters
    }
}
