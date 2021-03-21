//
//  APIProvider.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

import Foundation
import NetworkService

public protocol APIProvider {
    
    typealias Completion<T> = (Result<T, APIError>) -> ()
    
    typealias MainCompletion = Completion<MainResponse>
    typealias GameCompletion = Completion<GameConfig>

    var networkService: NetworkProvider { get }
    var config: APIConfig { get }
    
    func fetchMain(completion: @escaping MainCompletion)
    func fetchGame(with id: String,
                   completion: @escaping GameCompletion)

}

public extension APIProvider {
    
    func fetchMain(completion: @escaping MainCompletion) {

        do {
            let resource = try makeMainResource()
            fetch(from: resource, completion: completion)
        } catch APIError.couldNotParseURL {
            completion(.failure(.couldNotParseURL))
        } catch {
            completion(.failure(.unknownError(error)))
        }
    }
    
    func fetchGame(with id: String,
                   completion: @escaping GameCompletion) {
        do {
            let resource = try makeGameResource(for: id)
            fetch(from: resource, completion: completion)
        } catch APIError.couldNotParseURL {
            completion(.failure(.couldNotParseURL))
        } catch {
            completion(.failure(.unknownError(error)))
        }
    }
    
}

extension APIProvider {
    
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
    
    func makeMainResource() throws -> Resource {
        
        let path = config.mainPath
        let components = makeComponents(with: path)
        
        guard let url = components.url else {
            throw APIError.couldNotParseURL
        }
        
        return Resource(method: .get, url: url)
    }
    
    func makeGameResource(for id: String) throws -> Resource {
        
        let path = config.gamePath + "/\(id)"
        let components = makeComponents(with: path)
        
        guard let url = components.url else {
            throw APIError.couldNotParseURL
        }
        
        return Resource(method: .get, url: url)
    }
    
    func makeComponents(with path: String) -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = config.scheme
        components.host = config.host
        components.path = path
        
        return components
    }
    
}
