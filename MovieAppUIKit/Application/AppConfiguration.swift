//
//  AppConfigurations.swift
//  MovieAppUIKit
//
//  Created by Paul on 22/04/2022.
//

import Foundation

class AppConfiguration {
    // TODO: Have these configurations fetched at app startup from https://developers.themoviedb.org/3/configuration/get-api-configuration
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    lazy var imagesBaseURL: String = {
        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
            fatalError("imagesBaseURL must not be empty in plist")
        }
        return imageBaseURL
    }()
}
