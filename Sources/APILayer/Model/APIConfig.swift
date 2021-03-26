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
    
    public init(scheme: String,
                host: String,
                mainPath: String,
                favouritesPath: String,
                favouriteGamePath: String,
                recentPath: String) {
        
        self.scheme = scheme
        self.host = host
        self.mainPath = mainPath
        self.favouritesPath = favouritesPath
        self.recentPath = recentPath
        self.favouriteGamePath = favouriteGamePath
    }
    
}
