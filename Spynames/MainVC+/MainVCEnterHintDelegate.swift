import AVFoundation
import UIKit

protocol MainVCEnterHintDelegate: class {
    func addHint(hint: Hint)
    func nextTurn()
    func currentTeam() -> Team
}

//MARK: - delegates
extension MainVC: MainVCEnterHintDelegate {
    func addHint(hint: Hint) {
        game.hints[game.currentPlayer.team]!.append(hint.copy() as! Hint)
        let message = Message(text: hint.text+": "+Helper.StrInf(hint.qty), team: game.currentPlayer.team, player: .spymaster)
        chatView.add(message)
    }
    func nextTurn() {
        nextTurn(withPause: true)
    }
    func currentTeam() -> Team {
        return game.currentPlayer.team
    }
    
}
