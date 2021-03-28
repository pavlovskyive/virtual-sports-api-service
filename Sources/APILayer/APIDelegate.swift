//
//  File.swift
//  
//
//  Created by Vsevolod Pavlovskyi on 28.03.2021.
//

import Foundation

public protocol APIDelegate: class {
    
    func onFavouritesChanged()
    func onRecentsChanged()
    
}
