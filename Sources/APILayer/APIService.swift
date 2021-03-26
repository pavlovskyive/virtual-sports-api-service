//
//  APIService.swift
//
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

import NetworkService
import Foundation

final public class APIService: APIFetchable {

    var networkProvider: NetworkProvider
    var config: APIConfig

    public init(networkProvider: NetworkProvider,
                config: APIConfig) {
        self.networkProvider = networkProvider
        self.config = config
        
        networkProvider.setHeader("ios", forKey: "X-Platform")
        networkProvider.setHeader("accept", forKey: "application/json")
    }

    public func fetchMain(completion: @escaping MainCompletion) {

        guard let resource = makeMainResource() else {
            completion(.failure(.internalError))
            return
        }
        
        fetch(from: resource, completion: completion)
    }
    
    public func fetchFavourites(completion: @escaping GamesCompletion) {

        guard let resource = makeFavouritesResource() else {
            completion(.failure(.internalError))
            return
        }
        
        fetch(from: resource, completion: completion)
    }
    
    public func fetchRecent(completion: @escaping GamesCompletion) {

        guard let resource = makeRecentResource() else {
            completion(.failure(.internalError))
            return
        }
        
        fetch(from: resource, completion: completion)
    }
    
    public func addFavorite(gameId: String, completion: @escaping ErrorCompletion) {
        
        guard let resource = makeAddFavouriteResource(gameId: gameId) else {
            completion(.internalError)
            return
        }
        
        perform(to: resource, completion: completion)
    }

    public func removeFavorite(gameId: String, completion: @escaping ErrorCompletion) {

        guard let resource = makeRemoveFavouriteResource(gameId: gameId) else {
            completion(.internalError)
            return
        }
        
        perform(to: resource, completion: completion)
    }

}

extension APIService {

    func fetch<T: Decodable>(from resource: Resource,
                             completion: @escaping Completion<T>) {

        networkProvider.performRequest(for: resource, decodingTo: T.self) { result in
            switch result {
            case .success(let object):
                completion(.success(object))
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }

    func perform(to resource: Resource,
               completion: @escaping ErrorCompletion) {

        networkProvider.performRequest(for: resource) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(.networkError(error))
            }
        }
    }

    func makeMainResource() -> Resource? {

        let path = config.mainPath
        let components = makeComponents(with: path)

        guard let url = components.url else {
            return nil
        }

        return Resource(method: .get, url: url)
    }
    
    func makeFavouritesResource() -> Resource? {

        let path = config.favouritesPath
        let components = makeComponents(with: path)

        guard let url = components.url else {
            return nil
        }

        return Resource(method: .get, url: url)
    }

    func makeRecentResource() -> Resource? {

        let path = config.recentPath
        let components = makeComponents(with: path)

        guard let url = components.url else {
            return nil
        }

        return Resource(method: .get, url: url)
    }
    
    func makeAddFavouriteResource(gameId: String) -> Resource? {

        let path = config.favouriteGamePath
        let components = makeComponents(with: path)

        guard var url = components.url else {
            return nil
        }
        
        url.appendPathComponent(gameId)

        return Resource(method: .post, url: url)
    }
    
    func makeRemoveFavouriteResource(gameId: String) -> Resource? {

        let path = config.favouriteGamePath
        let components = makeComponents(with: path)

        guard var url = components.url else {
            return nil
        }
        
        url.appendPathComponent(gameId)

        return Resource(method: .delete, url: url)
    }

    func makeComponents(with path: String) -> URLComponents {

        var components = URLComponents()

        components.scheme = config.scheme
        components.host = config.host
        components.path = path

        return components
    }

}

