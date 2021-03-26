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
        
        guard let resource = makeFavouriteChangeResource(gameId: gameId, with: .post) else {
            completion(.internalError)
            return
        }
        
        perform(to: resource, completion: completion)
    }

    public func removeFavorite(gameId: String, completion: @escaping ErrorCompletion) {

        guard let resource = makeFavouriteChangeResource(gameId: gameId, with: .delete) else {
            completion(.internalError)
            return
        }
        
        perform(to: resource, completion: completion)
    }
    
    public func playGame(gameId: String, bet: Bet?, completion: @escaping BetCompletion) {

        guard let bet = bet,
              let resource = makePlayGameResource(gameId: gameId, bet: bet) else {
            completion(.failure(.internalError))
            return
        }

        fetch(from: resource, completion: completion)
    }
    
    public func fetchGameHistory(for gameId: String, completion: @escaping BetsHistoryCompletion) {

        guard let resource = makeGameHistoryResource(gameId: gameId) else {
            completion(.failure(.internalError))
            return
        }

        fetch(from: resource, completion: completion)
    }
    
    public func fetchDiceHistory(completion: @escaping BetsHistoryCompletion) {
        
        guard let resource = makeDiceHistoryResource() else {
            completion(.failure(.internalError))
            return
        }

        fetch(from: resource, completion: completion)
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
    
    func makeFavouriteChangeResource(gameId: String, with method: HTTPMethod) -> Resource? {

        let path = config.favouriteGamePath
        let components = makeComponents(with: path)

        guard var url = components.url else {
            return nil
        }
        
        url.appendPathComponent(gameId)

        return Resource(method: method, url: url)
    }
    
    func makePlayGameResource(gameId: String, bet: Bet) -> Resource? {
        
        let path = config.playGamePath
        let components = makeComponents(with: path)

        guard var url = components.url,
              let body = try? JSONEncoder().encode(bet) else {
            return nil
        }
        
        url.appendPathComponent(gameId)

        return Resource(method: .post, url: url, body: body)
    }
    
    func makeGameHistoryResource(gameId: String) -> Resource? {

        let path = config.gameHistoryPath
        let components = makeComponents(with: path)

        guard var url = components.url else {
            return nil
        }
        
        url.appendPathComponent(gameId)

        return Resource(method: .get, url: url)
    }
    
    // Temp (on backend not knowing what to do).
    func makeDiceHistoryResource() -> Resource? {
        
        let path = "/User/history"
        let components = makeComponents(with: path)
        
        guard let url = components.url else {
            return nil
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

