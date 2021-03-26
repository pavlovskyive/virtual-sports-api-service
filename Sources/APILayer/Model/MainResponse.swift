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

    public let providers: [Provider]
    public let categories: [GameCategory]
    public let tags: [Tag]
    public let games: [Game]
    
    public init(providers: [Provider],
                  categories: [GameCategory],
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

    public let id: String
    public let name: String
    public let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
        case imageURL = "image"
    }

    public init(id: String, name: String, imageURL: String) {

        self.id = id
        self.name = name
        self.imageURL = imageURL
    }

}

// MARK: - Category
public struct GameCategory: Codable {

    public let id: String
    public let name: String
    public let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "displayName"
        case imageURL = "image"
    }

    public init(id: String, name: String, imageURL: String) {

        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
}

// MARK: - Tag
public struct Tag: Codable {

    public let id: String
    public let name: String
    
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

    public let id, provider: String
    public let categories: [String]
    public let name: String
    public let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, provider, categories
        case name = "displayName"
        case tags
    }

    public init(id: String,
                provider: String,
                categories: [String],
                name: String,
                tags: [String]) {

        self.id = id
        self.provider = provider
        self.categories = categories
        self.name = name
        self.tags = tags
    }
    
}
