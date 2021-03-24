//
//  APIService.swift
//
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

import NetworkService
import Foundation

final public class APIService: APIFetcher {

    var networkService: NetworkProvider
    var config: APIConfig
    var token: String? = nil

    public init(config: APIConfig) {
        self.networkService = NetworkService(defaultHeaders: ["X-Platform": "Mobile"])
        self.config = config
    }

    public func fetchMain(completion: @escaping MainCompletion) {

        guard let resource = makeMainResource() else {
            completion(.failure(.internalError))
            return
        }
        
        fetch(from: resource, completion: completion)
    }
}

extension APIService {

    func fetch<T: Decodable>(from resource: Resource,
                             completion: @escaping Completion<T>) {

        networkService.performRequest(for: resource, decodingTo: T.self) { result in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }

    func makeMainResource() -> Resource? {

        let path = config.mainPath
        let components = makeComponents(with: path)

        guard let url = components.url else {
            return nil
        }
        
        guard let token = token else {
            return Resource(method: .get, url: url)
        }

        return Resource(method: .get, url: url, headers: ["Bearer token": token])
    }

    func makeComponents(with path: String) -> URLComponents {

        var components = URLComponents()

        components.scheme = config.scheme
        components.host = config.host
        components.path = path

        return components
    }

}

