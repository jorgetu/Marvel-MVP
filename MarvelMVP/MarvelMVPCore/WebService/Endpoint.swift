//
//  Endpoint.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

internal enum Endpoint {
    case comics(offset: Int)
}

internal extension Endpoint {

    func request(with baseURL: URL, adding parameters: [String: String]) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)

        var newParameters = self.parameters
        parameters.forEach { newParameters.updateValue($1, forKey: $0) }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = newParameters.map(URLQueryItem.init)

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue

        return request
    }
}

private enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

// MARK: - Endpoint variables
private extension Endpoint {

    var method: HTTPMethod {
        switch self {
        case .comics:
            return .get
        }
    }

    var path: String {
        switch self {
        case .comics:
            return "comics"
        }
    }

    var parameters: [String: String] {
        switch self {
        case .comics(let offset):
            let timestamp = "\((NSDate().timeIntervalSince1970 * 1000.0).rounded())"
            let hash = "\(timestamp)\(String.Constants.privateKey)\(String.Constants.apiKey)".MD5
            return ["apikey": String.Constants.apiKey ,"ts": timestamp,"hash" : hash, "offset": "\(offset)"]
        }
    }
    
}

