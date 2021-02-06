//
//  WebService.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

internal final class WebService {

    // MARK: - Properties
    private let session: URLSession
    private let decoder = JSONDecoder()
    private let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public")!

    // MARK: - Variables
    private var dataTask: URLSessionDataTask?

    // MARK: - Initializers
    init(session: URLSession) {
        self.session = session
    }

    // MARK: - Internal Methods
    func load<T>(_ type: T.Type,
                 from endpoint: Endpoint,
                 completion completed: @escaping (Result<T, ServiceError>) -> Void) where T: Decodable {

        let decoder = self.decoder
        let request = endpoint.request(with: baseURL, adding: [:])

        dataTask = session.dataTask(with: request,
                                    completionHandler: { data, response, error in

            if let error = error {
                completed(.failure(ServiceError.mapServiceError(error: error as NSError)))
            } else {

                guard let httpResponse = response as? HTTPURLResponse else {
                    completed(.failure(.internalServer))
                    return
                }

                if 200 ..< 300 ~= httpResponse.statusCode {
                    if let data = data {
                        if let result = try? decoder.decode(T.self, from: data) {
                            completed(.success(result))
                        } else {
                            completed(.failure(.mappingFailed))
                        }
                    } else {
                        completed(.failure(.noContent))
                    }

                } else {
                    let error = NSError(domain: "", code: httpResponse.statusCode)
                    completed(.failure(ServiceError.mapServiceError(error: error)))
                }
            }
        })

        dataTask?.resume()
    }
}

