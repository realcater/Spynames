import AVFoundation
import UIKit

protocol MainVCGameDelegate: class {
    func deleteFromWordsTable(card: Card)
    func gameOver(withBomb: Bool)
}

extension MainVC: MainVCGameDelegate {
    func deleteFromWordsTable(card: Card) {
        wordsTVC.deleteCard(card: card)
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

