//
//  GameSession.swift
//  XO-game
//
//  Created by Евгений Старшов on 17.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

final class GameSession {
    
    static let shared = GameSession()
    private init() {}
    
    var mode: gameMode?
    
    var playerFirstMoves: [PlayerMoves] = []
    var playerSecondMoves: [PlayerMoves] = []
}
