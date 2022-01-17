

import UIKit

enum gameMode {
    case pvp
    case vsAI
    case fiveByfive
}

class GameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet weak var vsAIbutton: UIButton!
    @IBOutlet weak var pvpButton: UIButton!
    
    private let gameboard = Gameboard()
    private lazy var referee = Referee(gameboard: self.gameboard)
    private var counter = 0
    
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    private func goToFirstState() {
        let player = Player.first
        self.currentState = PlayerInputState(player: player,
                                             gameViewController: self, markViewPrototype: player.markViewPrototype,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }
    
    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        if let playerInputState = currentState as? PlayerInputState {
            let player = playerInputState.player.next
            self.currentState = PlayerInputState(player: player,
                                                 gameViewController: self, markViewPrototype: player.markViewPrototype,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
        }
    }
    
    // --- IBActions:
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        gameboardView.clear()
        gameboard.clear()
        goToFirstState()
        GameSession.shared.playerFirstMoves = []
        GameSession.shared.playerSecondMoves = []
        counter = 0
    }
}

