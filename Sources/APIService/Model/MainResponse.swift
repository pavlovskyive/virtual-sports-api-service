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
    
    public init(providers: [Provider],
                  categories: [Category],
                  tags: [Tag],
                  games: [Game]) {

        self.providers = providers
        self.categories = categories
        self.tags = tags
        self.games = games
    }

}

// MARK: - Provider
public struct Provider: Codable {

    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
    }

    public init(id: String, name: String) {

        self.id = id
        self.name = name
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

    public init(id: String, name: String) {

        self.id = id
        self.name = name
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

    public init(id: String, name: String) {

        self.id = id
        self.name = name
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

    public init(id: String,
                provider: String,
                category: [String],
                name: String,
                tags: [String]) {

        self.id = id
        self.provider = provider
        self.category = category
        self.name = name
        self.tags = tags
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
    
    public init(url: String, image: String, game: Game) {

        self.url = url
        self.image = image
        self.game = game
    }

}
