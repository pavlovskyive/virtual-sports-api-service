//
//  APIFetchable.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

import Foundation
import NetworkService

public protocol APIFetchable {

    typealias Completion<T> = (Result<T, APIError>) -> Void
    typealias ErrorCompletion = (APIError?) -> Void
    
    typealias MainCompletion = Completion<MainResponse>
    typealias GamesCompletion = Completion<[Game]>
    
    func fetchMain(completion: @escaping MainCompletion)
    func fetchFavourites(completion: @escaping GamesCompletion)
    func fetchRecent(completion: @escaping GamesCompletion)
    
    func addFavorite(gameId: String, completion: @escaping ErrorCompletion)
    func removeFavorite(gameId: String, completion: @escaping ErrorCompletion)

}
