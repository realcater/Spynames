import AVFoundation
import UIKit

protocol MainVCDelegate: class {
    func changeCardsColorVisibility(fade: Bool, alwaysHide: Bool)
    func deleteFromWordsTable(card: Card)
    func updateScoreLabels()
    func updateLeftWordsQtyLabels()
    func pressed(uicard: UICard)
    func showAllWords()
    func gameOver(withBomb: Bool)
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
    func showAllWords() {
        for uicard in uicards {
            uicard.showWordIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                uicard.hideWordIfNeeded()
            })
        }
    }
    func gameOver(withBomb: Bool = false) {
        changeCardsColorVisibility(fade: true)
        
        let winner = withBomb ? game.currentPlayer.team.next().getDescription() : game.currentPlayer.team.getDescription()
        
        let title = K.Labels.gameOverAlert.title.replacingOccurrences(of: "XXX", with: winner)
        let message = K.Labels.gameOverAlert.message[withBomb]!
        let buttonText = K.Labels.gameOverAlert.buttonsText[0]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + K.Delays.nextTurnAlert, execute: {
            self.addAlertDialog(title: title, message: message, buttonText: buttonText, pressedButtonAction: self.startNewGame)
        })
    }
}

