//
//  MainResponse.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

// Note: Naming on API is not regulated yet, may change later.

import Foundation

// MARK: - MainResponse
public struct MainResponse: Codable {

    let providers: [Provider]
    let categories: [Category]
    let tags: [Tag]
    let games: [Game]

}

// MARK: - Provider
public struct Provider: Codable {

    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
    }
    
}

// MARK: - Category
public struct Category: Codable {

    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
    }

}

// MARK: - Tag
public struct Tag: Codable {

    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
    }
}


// MARK: - Game
public struct Game: Codable {

    let id, provider: String
    let category: [String]
    let name: String
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, provider, category
        case name = "displayName"
        case tags
    }

}

// MARK: - GameConfig
public struct GameConfig: Codable {

    let url: String
    let image: String
    let game: Game
    
    enum CodingKeys: String, CodingKey {
        case url
        case image = "backgroundImage"
        case game
    }
}
