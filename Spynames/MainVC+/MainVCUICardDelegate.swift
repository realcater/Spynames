import AVFoundation
import UIKit

protocol MainVCUICardDelegate: class {
    func updateScoreLabels()
    func updateLeftWordsQtyLabels()
    func pressed(uicard: UICard)
    func showAllWords()
    var sizeX: Int {get}
    var sizeY: Int {get}
    
}

extension MainVC: MainVCUICardDelegate {
    var sizeX: Int {
        return game.sizeX
    }
    var sizeY: Int {
        return game.sizeY
    }
    
    func updateScoreLabels() {
        guessedRedLabel.text = String(game.score[.redTeam]!)
        guessedBlueLabel.text = String(game.score[.blueTeam]!)
    }
    func updateLeftWordsQtyLabels() {
        leftRedLabel.text = String(game.leftWordsQty[.redTeam]!)
        leftBlueLabel.text = String(game.leftWordsQty[.blueTeam]!)
    }
    func pressed(uicard: UICard) {
        switch (game.isOver, game.currentPlayer.type, uicard.card.guessed) {
        case (true, _, true):
            showAllWords()
        case (true, _, false):
            break
        case (false, _, true):
            showAllWords()
        case (false,.operatives, false):
            if game.canGuessMore {
                uicard.cover()
                let message = Message(text: uicard.card.word, team: game.currentPlayer.team, player: .operatives, cardColor: uicard.card.color)
                if !game.isTutorial || game.currentPlayer.team == .redTeam {
                    chatView.add(message)
                }
                if !game.canGuessMore {
                    nextTurn()
                } else {
                    updateTitleBar()
                }
            }
        case (false, .spymaster, false):
            changeLegendVisibility(fade: false)
        }
    }
    func showAllWords() {
        for uicard in uicards {
            uicard.showWordIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + K.Delays.showAllWords, execute: {
                uicard.hideWordIfNeeded()
            })
        }
    }
}

