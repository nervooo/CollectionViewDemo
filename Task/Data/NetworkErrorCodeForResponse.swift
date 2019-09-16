//
//  NetworkErrorCodeForResponse.swift
//  Resturant
//
//  Created by Nervana Adel on 9/15/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import Foundation

enum NetworkErrorCodeForResponse: Error {
    case errorInParsingResponse
    case errorStatus
    case noInternet
    case invalidURL
    case invalidAPIToken
}

extension NetworkErrorCodeForResponse: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .errorInParsingResponse:
            return "errorInParsingResponse "
        case .errorStatus:
            return "errorStatus"
        case .noInternet:
            return "noInternet"
        case .invalidURL:
            return "invalidURL"
        case .invalidAPIToken:
            return "Please login again"
        }
    }
}
