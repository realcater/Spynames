import AVFoundation
import UIKit

protocol MainVCDelegate: class {
    func showLegend(fade: Bool, color: CardColor?)
    func hideLegend(fade: Bool, color: CardColor?)
    func changeLegendVisibility(fade: Bool)
    func deleteFromWordsTable(card: Card)
    func updateScoreLabels()
    func updateLeftWordsQtyLabels()
    func pressed(uicard: UICard)
    func showAllWords()
    func gameOver(withBomb: Bool)
}

extension MainVC: MainVCDelegate {
    func showLegend(fade: Bool, color: CardColor? = nil) {
        for uicard in uicards {
            if color == nil || (uicard.card.color == color!) {
                uicard.showColor(fade: fade)
            }
        }
        if color == nil || color == .red || color == .blue {
            wordsTVC.show()
            game.showLegend = true
        }
    }
    
    func hideLegend(fade: Bool, color: CardColor? = nil) {
        for uicard in uicards {
            if color == nil || (uicard.card.color == color!) {
                uicard.hideColor(fade: fade)
            }
        }
        if color == nil || color == .red || color == .blue  {
            wordsTVC.hide()
            game.showLegend = false
        }
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
    func gameOver(withBomb: Bool = false) {
        var alert: UIAlertController!
        game.isOver = true
        showLegend(fade: true)

        let winner = withBomb ? game.currentPlayer.team.next().getDescription() : game.currentPlayer.team.getDescription()
        
        let title = K.Labels.gameOverAlert.title.replacingOccurrences(of: "XXX", with: winner)
        let message = K.Labels.gameOverAlert.message[withBomb]!
        let alertButtons = [
            AlertButton(text: K.Labels.gameOverAlert.buttonsText[0], action: self.startNewGame),
            AlertButton(text: K.Labels.gameOverAlert.buttonsText[1], action: self.LookAround)
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + K.Delays.nextTurnAlert, execute: {
            alert = self.addAlertDialog(title: title, message: message, alertButtons: alertButtons)
        })
        if game.isTutorial {
            DispatchQueue.main.asyncAfter(deadline: .now() + K.Delays.nextTurnAlert + T.Delay.skipAlertGameOver, execute: {
                alert.dismiss(animated: true, completion: alertButtons[1].action)
            })
        }
    }
}

