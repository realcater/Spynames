import AVFoundation
import UIKit

protocol MainVCDelegate: class {
    func changeCardsColorVisibility(fade: Bool, alwaysHide: Bool)
    func deleteFromWordsTable(card: Card)
    func updateScoreLabels()
    func updateLeftWordsQtyLabels()
    func pressed(uicard: UICard)
    func showAllWords()
}

extension MainVC: MainVCDelegate {
    func changeCardsColorVisibility(fade: Bool, alwaysHide: Bool = false) {
        for uicard in uicards {
            uicard.changeShowColor(fade: fade, alwaysHide: alwaysHide)
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
                //showAllWords()
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
    func showAllWords() {
        for uicard in uicards {
            uicard.showWordIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                uicard.hideWordIfNeeded()
            })
        }
    }
}

