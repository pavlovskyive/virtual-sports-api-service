//
//  APIError.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

import Foundation
import NetworkService

public enum APIError: Error {

    case networkError(NetworkError)
    case couldNotParseURL
    case unknownError(Error)

}
