//
//  AIInputState.swift
//  XO-game
//
//  Created by Евгений Старшов on 17.01.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

public class AIinputState: PlayerInputState {
    
    public override func begin() {
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = false
        
        if let position = calculatePosition() {
            addMark(at: position)
        }

        gameViewController?.winnerLabel.isHidden = true
    }
    

    
    private func calculatePosition() -> GameboardPosition? {
        var positions: [GameboardPosition] = []

        for col in 0...GameboardSize.columns - 1 {
            for row in 0...GameboardSize.rows - 1 {
                let position = GameboardPosition(column: col, row: row)
                if gameboardView!.canPlaceMarkView(at: position) {
                    positions.append(position)
                }
            }
        }
        
        return positions.randomElement()
    }
}

//public class AIinputState: GameState {
//
//    public let markViewPrototype: MarkView
//    public private(set) var isCompleted = false
//    public let player: Player
//    private(set) weak var gameViewController: GameViewController?
//    private(set) weak var gameboard: Gameboard?
//    private(set) weak var gameboardView: GameboardView?
//
//
//    init(player: Player, gameViewController: GameViewController, markViewPrototype: MarkView, gameboard: Gameboard, gameboardView: GameboardView) {
//        self.player = player
//        self.gameViewController = gameViewController
//        self.gameboard = gameboard
//        self.gameboardView = gameboardView
//        self.markViewPrototype = markViewPrototype
//    }
//
//
//
//    public func begin() {
//        switch self.player {
//        case .first:
//            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
//            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
//        case .second:
//            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
//            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
//        }
//
//        self.gameViewController?.winnerLabel.isHidden = true
//    }
//
//    public func addMark(at position: GameboardPosition) {
//        Log(.playerInput(player: self.player, position: position))
//        guard let gameboardView = self.gameboardView
//                , gameboardView.canPlaceMarkView(at: position)
//                else { return }
//
//            self.gameboard?.setPlayer(self.player, at: position)
//            self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
//            self.isCompleted = true
//    }
//
//
//}
