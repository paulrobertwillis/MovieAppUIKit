//
//  ResponseDecoder.swift
//  MovieAppUIKit
//
//  Created by Paul on 23/04/2022.
//


// TODO: Replace with DataParser

import Foundation

protocol ResponseDecoderProtocol {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

class JSONResponseDecoder: ResponseDecoderProtocol {
    private let jsonDecoder = JSONDecoder()
    
    func decode<T>(_ data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

class RawDataResponseDecoder: ResponseDecoderProtocol {
    func decode<T>(_ data: Data) throws -> T where T : Decodable {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = Swift.DecodingError.Context(codingPath: [], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
