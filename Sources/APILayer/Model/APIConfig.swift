//
//  APIConfig.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

import Foundation

public struct APIConfig {
    
    var scheme: String
    var host: String

    var mainPath: String
    var favouritesPath: String
    var favouriteGamePath: String
    var recentPath: String
    var playGamePath: String
    var gameHistoryPath: String
    var recommendedPath: String
    
    public init(scheme: String,
                host: String,
                mainPath: String,
                favouritesPath: String,
                favouriteGamePath: String,
                recentPath: String,
                playGamePath: String,
                gameHistoryPath: String,
                recommendedPath: String) {
        
        self.scheme = scheme
        self.host = host
        self.mainPath = mainPath
        self.favouritesPath = favouritesPath
        self.favouriteGamePath = favouriteGamePath
        self.recentPath = recentPath
        self.playGamePath = playGamePath
        self.gameHistoryPath = gameHistoryPath
        self.recommendedPath = recommendedPath
    }
    
}
