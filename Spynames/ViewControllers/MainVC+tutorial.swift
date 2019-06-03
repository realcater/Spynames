import UIKit

struct T {
    static var prevTutorialTime: Date!
    static var messageNumber: Int = 0
    static let messages = [
        Message(text: "Hi, this is Spynames!", team: .redTeam, player: .spymaster, delay: Delay.std),
        Message(text: "A game for brave young Spymasters", team: .redTeam, player: .spymaster, delay: Delay.std),
        Message(text: "and their Operatives", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "who compete in intelligence and cohesion!", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "There are two teams:", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "RED", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "and BLUE", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "Each team has:", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "Spymaster (1 person)", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "Operatives (1 or more persons)", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "There are 25 Spynames", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "9 of one team", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "8 of another", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "1 is a bomb!", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "and the rest are civilians", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "Only Spymasters know who is who", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "and Operatives don't know", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "Spymaster's task is to give their Operatives a hint", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "that helps them to learn which their words are", team: .blueTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "She can group her words in a list on the right:", team: .redTeam, player: .spymaster, delay: Delay.std),
        Message(text: "drag-and-drop to move", team: .redTeam, player: .spymaster, delay: 4.2),
        Message(text: "double-tap to separate", team: .redTeam, player: .spymaster, delay: Delay.std3),
        Message(text: "And she come up with a hint that combines some of them", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "First 3 words in our case:", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "\(Ru.tutorialWords[7]), \(Ru.tutorialWords[1]) and \(Ru.tutorialWords[23])", team: .redTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "Than she tells her operatives this hint", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "and a number showing how many words are combined", team: .blueTeam, player: .spymaster, delay: 7.0),
        Message(text: "It's Operatives' turn now", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "They choose what words suit better", team: .redTeam, player: .operatives, delay: Delay.std3),
        Message(text: "They can guess no more than the number of words Spymaster combined", team: .blueTeam, player: .operatives, delay: Delay.std),
        Message(text: "plus one", team: .blueTeam, player: .operatives, delay: 5.5),
        Message(text: "And they stop guessing as soon as", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "they make a mistake", team: .redTeam, player: .operatives, delay: 6.0),
        Message(text: "After that another Spymaster", team: .blueTeam, player: .spymaster, delay: Delay.std),
        Message(text: "makes his turn", team: .blueTeam, player: .spymaster, delay: 7.5),
        Message(text: "The game ends when one team", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "guess all its words", team: .blueTeam, player: .operatives, delay: 7.8),
        Message(text: "This team is a winner", team: .blueTeam, player: .spymaster, delay: Delay.std2),
        Message(text: "Or", team: .redTeam, player: .operatives, delay: Delay.std),
        Message(text: "The game ends if one team", team: .redTeam, player: .operatives, delay: Delay.std2),
        Message(text: "guess the bomb!", team: .redTeam, player: .operatives, delay: 4.5),
        Message(text: "That team is a looser", team: .redTeam, player: .spymaster, delay: 4.5),
        Message(text: "Good luck!", team: .blueTeam, player: .spymaster)
    ]
    static let tutorialColors: [CardColor] = [
        .red, .red, .blue, .neutral, .neutral,
        .blue, .red, .red, .neutral, .blue,
        .black, .blue, .blue, .blue, .neutral,
        .neutral, .red, .blue, .neutral, .red,
        .blue, .red, .red, .red, .neutral
    ]
    static let lastSixRedCardsNums = [12,5,2,20,9,11,17,13]
    
    struct Delay {
        static let totalBefore: [Double] = {
            var result: [Double] = [0]
            var sum: Double = 0
            for m in messages.dropLast() {
                sum+=m.delay
                result.append(sum)
            }
            return result
        }()
        static let total = T.Delay.totalBefore.last! + messages.last!.delay
        static let betweenCards = 0.5
        static let enterHintText = 0.8
        static let changePicker = 0.5
        static let skipAlert = 1.4
        static let skipAlertGameOver = 2.3
        static let std = 1.7
        static let std2 = 2.8
        static let std3 = 3.4
    }
    static let picker = [
        Team.redTeam: 2,
        Team.blueTeam: 7
    ]
}

extension MainVC {
    func tutorial() {
        leftButtonState = .tutorial
        titleBar.text = "How it works?"
        game = Game(isTutorial: true)
        game.delegate = self
        T.prevTutorialTime = Date()
        
        for (i,m) in T.messages.enumerated() {
            Timer.scheduledTimer(withTimeInterval: T.Delay.totalBefore[i], repeats: false) { timer in
                self.chatView.add(m)
                self.showEventAfterMessage(messageNumber: i)
            }
        }
        /*T.messageNumber = 0
        chatView.add(T.messages[0])*/
            
    }
    func showNextMessage() {
        T.messageNumber+=1
        print("Message#\(T.messageNumber)")
        let message = T.messages[T.messageNumber]
        chatView.add(message)
        showEventAfterMessage(messageNumber: T.messageNumber)

        let dif = T.prevTutorialTime.timeIntervalSinceNow
        print(dif)
        T.prevTutorialTime = Date()
    }
    func showEventAfterMessage(messageNumber: Int) {
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
