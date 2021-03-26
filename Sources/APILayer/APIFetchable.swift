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
    typealias BetCompletion = Completion<Bet>
    typealias BetsHistoryCompletion = Completion<[Bet]>
    
    func fetchMain(completion: @escaping MainCompletion)
    func fetchFavourites(completion: @escaping GamesCompletion)
    func fetchRecent(completion: @escaping GamesCompletion)
    func fetchGameHistory(for gameId: String, completion: @escaping BetsHistoryCompletion)
    
    func addFavorite(gameId: String, completion: @escaping ErrorCompletion)
    func removeFavorite(gameId: String, completion: @escaping ErrorCompletion)
    
    func playGame(gameId: String, bet: Bet?, completion: @escaping BetCompletion)
    
    // Hope backend will solve this, but for now:
    func fetchDiceHistory(completion: @escaping BetsHistoryCompletion)

}
