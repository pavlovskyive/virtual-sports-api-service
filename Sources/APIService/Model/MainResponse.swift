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
    let imageURL: String

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
public struct Category: Codable {

    let id: String
    let name: String
    let imageURL: String
    
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
    let categories: [String]
    let name: String
    let tags: [String]
    
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
