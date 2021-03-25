//
//  APIFetchable.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 20.03.2021.
//

import Foundation
import NetworkService

public protocol APIFetchable {

    typealias Completion<T> = (Result<T, APIError>) -> ()
    
    typealias MainCompletion = Completion<MainResponse>
    
    func fetchMain(completion: @escaping MainCompletion)

}
