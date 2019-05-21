import AVFoundation
import UIKit

protocol MainVCDelegate: class {
    func showLegend(fade: Bool)
    func hideLegend(fade: Bool)
    func changeLegendVisibility(fade: Bool)
    func deleteFromWordsTable(card: Card)
    func updateScoreLabels()
    func updateLeftWordsQtyLabels()
    func pressed(uicard: UICard)
    func showAllWords()
    func gameOver(withBomb: Bool)
}

extension MainVC: MainVCDelegate {
    func showLegend(fade: Bool) {
        for uicard in uicards {
            uicard.showColor(fade: fade)
        }
        wordsTVC.show()
        game.showLegend = true
    }
    func hideLegend(fade: Bool) {
        for uicard in uicards {
            uicard.hideColor(fade: fade)
        }
        wordsTVC.hide()
        game.showLegend = false
    }
    func changeLegendVisibility(fade: Bool) {
        if game.showLegend {
            hideLegend(fade: fade)
        } else {
            showLegend(fade: fade)
        }
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
        switch (game.currentPlayer.type, uicard.card.guessed) {
        case (_, true):
            showAllWords()
        case (.operatives, false):
            if game.canGuessMore {
                uicard.flip()
                let message = Message(text: uicard.card.word, team: game.currentPlayer.team, player: .operatives, cardColor: uicard.card.color)
                chatView.add(message)
                if !game.canGuessMore {
                    nextTurn()
                } else {
                    updateTitleBar()
                }
            }
        case (.spymaster, false):
            changeLegendVisibility(fade: false)
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
        showLegend(fade: true)
        
        let winner = withBomb ? game.currentPlayer.team.next().getDescription() : game.currentPlayer.team.getDescription()
        
        let title = K.Labels.gameOverAlert.title.replacingOccurrences(of: "XXX", with: winner)
        let message = K.Labels.gameOverAlert.message[withBomb]!
        let buttonText = K.Labels.gameOverAlert.buttonsText[0]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + K.Delays.nextTurnAlert, execute: {
            self.addAlertDialog(title: title, message: message, buttonText: buttonText, pressedButtonAction: self.startNewGame)
        })
    }
}

