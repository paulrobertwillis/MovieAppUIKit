//
//  Service.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

class Service {
    public let network: NetworkServiceProtocol
    
    public required init(network: NetworkServiceProtocol) {
        self.network = network
    }
}
