import AVFoundation
import UIKit

protocol ReturnHintDelegate: class {
    func addHint(hint: Hint)
    func nextTurn()
}

//MARK: - delegates
extension MainVC: ReturnHintDelegate {
    func addHint(hint: Hint) {
        game.hints[game.currentPlayer.team]!.append(hint.copy() as! Hint)
        let message = Message(text: hint.text+": "+Helper.StrInf(hint.qty), team: game.currentPlayer.team, player: .spymaster)
        chatView.add(message)
    }
    func nextTurn() {
        nextTurn(withPause: true)
    }
    
}
