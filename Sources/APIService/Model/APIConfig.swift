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
    var gamePath: String
    
    public init(scheme: String,
                host: String,
                mainPath: String,
                gamePath: String) {
        
        self.scheme = scheme
        self.host = host
        self.mainPath = mainPath
        self.gamePath = gamePath
    }
    
}
