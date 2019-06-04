import AVFoundation
import UIKit

extension MainVC {
    @IBAction func pressLeftButton(_ sender: Any) {
        switch leftButtonState {
        case .tutorial: showSkipTutorialAlert()
        case .hint: performSegue(withIdentifier: "toEnterHintVC", sender: sender)
        case .pass: nextTurn(withPause: false)
        case .newGame: startNewGame()
        }
    }
    func startNewGame() {
        game = Game()
        game.delegate = self
        
        updateScoreLabels()
        updateLeftWordsQtyLabels()
        updateStatusIcons()
        updateTitleBar()
        updateLeftButton()
        updateAndRevealWords()
        updateChat()
        placeCards()
    }
    
    func nextTurn(withPause: Bool = true) {
        var alert: UIAlertController!
        let delay = withPause ? K.Delays.nextTurnAlert : 0
        if game.currentPlayer.type == .spymaster {
            hideLegend(fade: true)
        }
        let alertButton = AlertButton(
            text: K.Labels.nextTurnAlert.buttonText,
            action: {
                if self.game.currentPlayer.type == .spymaster {
                    self.updatePersonalListFromTable()
                } else {
                    self.changeLegendVisibility(fade: true)                                     }
                self.game.nextTurn()
                self.updateStatusIcons()
                self.updateTitleBar()
                self.updateLeftButton()
                
                if self.game.currentPlayer.type == .spymaster {
                    self.updateTableFromPersonalList(withDelay: false)
                }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            alert = self.addAlertDialog(title: K.Labels.nextTurnAlert.title, message:
                K.Labels.nextTurnAlert.message[self.game.currentPlayer.type]!, alertButtons: [alertButton])
        })
        if game.isTutorial {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay+T.Delay.skipAlert, execute: {
                alert.dismiss(animated: true, completion: alertButton.action)
            })
        }
    }
    
    func placeCards() {
        zoomedView.clearSubviews()
        if K.CardsAnimation.show {
            DispatchQueue.main.asyncAfter(deadline: .now() + K.CardsAnimation.delaySound, execute: {
                K.Sounds.cards?.play()
            })
        }
        for y in 0..<K.Game.sizeY {
            for x in 0..<K.Game.sizeX {
                let num = y*K.Game.sizeX+x
                let place = Place(x: x, y: y)
                let delay = K.CardsAnimation.show ? K.CardsAnimation.betweenCardsAppear * Double(num) : 0
                let uicard = UICard(place: place, card: game.cards[num], showDelay: delay, in: zoomedView)
                uicard.delegate = self
                uicards.append(uicard)
            }
        }
    }
    func revealCardsColors(color: CardColor? = nil) {
        showLegend(fade: true, color: color)
        switch color {
        case .red?: updateTableFromPersonalList(withDelay: true, team: .redTeam)
        case .blue?: updateTableFromPersonalList(withDelay: true, team: .blueTeam)
        case nil: updateTableFromPersonalList(withDelay: true, team: game.currentPlayer.team)
        default: break
        }
    }
    func LookAround() {
        if game.isTutorial { return }
        leftButtonState = .newGame
    }
    func showSkipTutorialAlert() {
        tutorial.pause()
        let title = T.skipTutorialAlert.title
        let message = T.skipTutorialAlert.message
        let alertButtons = [
            AlertButton(text: T.skipTutorialAlert.buttonsText[0], action: self.startNewGame),
            AlertButton(text: T.skipTutorialAlert.buttonsText[1], action: tutorial.startContinue)
        ]
        _ = self.addAlertDialog(title: title, message: message, alertButtons: alertButtons)
    }
}
