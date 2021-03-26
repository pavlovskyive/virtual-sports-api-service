//
//  File.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 26.03.2021.
//

import Foundation

public struct Bet: Codable {
    
    public let dateTime: String
    public let betType: Int

    public let id: String?
    public let outcome: Int?
    public let didWin: Bool?

    enum CodingKeys: String, CodingKey {
        case dateTime, betType, id
        case outcome = "droppedNumber"
        case didWin = "isBetWon"
    }

    public init(dateTime: String,
                betType: Int,
                id: String? = nil,
                outcome: Int? = nil,
                didWin: Bool? = nil) {

        self.dateTime = dateTime
        self.betType = betType
        self.id = id
        self.outcome = outcome
        self.didWin = didWin
    }

}
