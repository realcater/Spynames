import AVFoundation
import UIKit

protocol MainVCDelegate: class {
    func changeCardsColorVisibility(fade: Bool)
    func deleteFromWordsTable(card: Card)
    func updateScoreLabels()
    func updateLeftWordsQtyLabels()
    func pressed(uicard: UICard)
}

extension MainVC: MainVCDelegate {
    func changeCardsColorVisibility(fade: Bool) {
        for uicard in uicards {
            uicard.changeShowColor(fade: fade)
        }
        wordsTVC.changeVisibility()
    }
    func deleteFromWordsTable(card: Card) {
        wordsTVC.deleteCard(card: card)
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
        switch game.currentPlayer.type {
        case .operatives:
            if uicard.card.guessed {
                showAllWords()
            } else if game.canGuessMore {
                uicard.flip()
                let message = Message(text: uicard.card.word, team: game.currentPlayer.team, player: .operatives, cardColor: uicard.card.color)
                chatView.add(message)
                if !game.canGuessMore {
                    nextTurn()
                } else {
                    updateTitleBar()
                }
            }
        case .spymaster:
            changeCardsColorVisibility(fade: false)
        }
    }
}

