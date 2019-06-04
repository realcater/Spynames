import AVFoundation
import UIKit

protocol MainVCTutorialDelegate: class {
    func prepareTutorial()
    func showSkipTutorialAlert()
    func showMessageAndEvent(message: Message, messageNumber: Int)
}

extension MainVC: MainVCTutorialDelegate {
    
    func prepareTutorial() {
        leftButtonState = .tutorial
        titleBar.text = "How it works?"
        game = Game(isTutorial: true)
        game.delegate = self
    }
    
    func showMessageAndEvent(message: Message, messageNumber: Int) {
        self.chatView.add(message)
        switch messageNumber {
        case 5:
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.blink = true
            statusIcons[Player(team: .redTeam, type: .operatives)]!.blink = true
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.active = true
            statusIcons[Player(team: .redTeam, type: .operatives)]!.active = true
        case 6:
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.blink = false
            statusIcons[Player(team: .redTeam, type: .operatives)]!.blink = false
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.active = false
            statusIcons[Player(team: .redTeam, type: .operatives)]!.active = false
            
            statusIcons![Player(team: .blueTeam, type: .spymaster)]!.blink = true
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.blink = true
            statusIcons![Player(team: .blueTeam, type: .spymaster)]!.active = true
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.active = true
        case 7:
            statusIcons![Player(team: .blueTeam, type: .spymaster)]!.blink = false
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.blink = false
            statusIcons![Player(team: .blueTeam, type: .spymaster)]!.active = false
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.active = false
        case 8:
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.blink = true
            statusIcons[Player(team: .blueTeam, type: .spymaster)]!.blink = true
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.active = true
            statusIcons[Player(team: .blueTeam, type: .spymaster)]!.active = true
        case 9:
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.blink = false
            statusIcons[Player(team: .blueTeam, type: .spymaster)]!.blink = false
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.active = false
            statusIcons[Player(team: .blueTeam, type: .spymaster)]!.active = false
            
            statusIcons![Player(team: .redTeam, type: .operatives)]!.blink = true
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.blink = true
            statusIcons![Player(team: .redTeam, type: .operatives)]!.active = true
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.active = true
        case 10:
            statusIcons![Player(team: .redTeam, type: .operatives)]!.blink = false
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.blink = false
            statusIcons![Player(team: .redTeam, type: .operatives)]!.active = false
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.active = false
            placeCards()
        case 11:
            revealCardsColors(color: .red)
        case 12:
            revealCardsColors(color: .blue)
        case 13:
            revealCardsColors(color: .black)
            wordsTVC.hide()
        case 15:
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.active = true
            statusIcons[Player(team: .blueTeam, type: .spymaster)]!.active = true
            hideLegend(fade: false)
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
                self.showLegend(fade: true)
            }
        case 16:
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.active = false
            statusIcons[Player(team: .blueTeam, type: .spymaster)]!.active = false
            statusIcons![Player(team: .redTeam, type: .operatives)]!.active = true
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.active = true
            hideLegend(fade: true)
        case 17:
            revealCardsColors()
            updateTitleBar()
            statusIcons![Player(team: .redTeam, type: .spymaster)]!.active = true
            statusIcons![Player(team: .redTeam, type: .operatives)]!.active = false
            statusIcons[Player(team: .blueTeam, type: .operatives)]!.active = false
        case 20:
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.wordsTVC.moveRow(at: 3, to: 0)
            }
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                self.wordsTVC.moveRow(at: 2, to: 1)
            }
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                self.wordsTVC.moveRow(at: 8, to: 2)
            }
        case 21:
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                self.wordsTVC.insertRow(card: Card(text: "", color: .neutral), at: 3)
            }
        case 26:
            Timer.scheduledTimer(withTimeInterval: T.Delay.std, repeats: false) { timer in
                self.performSegue(withIdentifier: "toEnterHintVC", sender: self.leftButton)
            }
        case 30:
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                self.pressed(uicard: self.uicards[1])
            }
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                self.pressed(uicard: self.uicards[23])
            }
        case 32:
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                self.pressed(uicard: self.uicards[3])
            }
            
        case 34:
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                self.performSegue(withIdentifier: "toEnterHintVC", sender: self.leftButton)
            }
        case 36:
            for (i,number) in T.lastSixRedCardsNums.enumerated() {
                Timer.scheduledTimer(withTimeInterval: T.Delay.betweenCards*Double(i), repeats: false) { _ in
                    self.pressed(uicard: self.uicards[number])
                }
            }
        case 40:
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.uicards[10].cover(withDuration: K.Delays.fadeTimeAppearCard)
            }
        case T.messages.count-1:
            leftButtonState = .newGame
        default: ()
        }
    }
}
