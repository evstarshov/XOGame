//
//  GameState.swift
//  XO-game
//
//  Created by Евгений Старшов on 14.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation


public protocol GameState {
    
    var isCompleted: Bool { get }
    
    func begin()
    
    func addMark(at position: GameboardPosition)
    
}


protocol Copying {
    init(_ prototype: Self)
}


extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
