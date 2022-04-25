//
//  Service.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

class Service {
    public let network: MoviesNetworkServiceProtocol
    
    public required init(network: MoviesNetworkServiceProtocol) {
        self.network = network
    }
}
