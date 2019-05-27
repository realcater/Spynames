import UIKit

struct T {
    static var prevTutorialTime: Date!
    static var messageNumber: Int = 0
    static let messages = [
        Message(text: "Hi, this is Spynames!", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "A game for brave young Spymasters", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "and their Operatives", team: .blueTeam, player: .operatives, delay: 1.0),
        Message(text: "who compete in intelligence and cohesion!", team: .blueTeam, player: .operatives, delay: 1.0),
        Message(text: "There are two teams:", team: .redTeam, player: .operatives, delay: 1.0),
        Message(text: "RED", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "and BLUE", team: .blueTeam, player: .spymaster, delay: 1.0),
        Message(text: "Each team has:", team: .redTeam, player: .operatives, delay: 1.0),
        Message(text: "Spymaster (1 person)", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "Operatives (1 or more persons)", team: .redTeam, player: .operatives, delay: 1.0),
        Message(text: "There are 25 Spynames", team: .blueTeam, player: .spymaster, delay: 1.0),
        Message(text: "9 of one team", team: .redTeam, player: .operatives, delay: 1.0),
        Message(text: "8 of another", team: .blueTeam, player: .spymaster, delay: 1.0),
        Message(text: "1 is a bomb!", team: .blueTeam, player: .spymaster, delay: 1.0),
        Message(text: "and the rest are civilians", team: .redTeam, player: .operatives, delay: 1.0),
        Message(text: "Spymasters know who is who", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "and Operatives don't know", team: .redTeam, player: .operatives, delay: 1.0),
        Message(text: "Spymaster's task is to give their Operatives a hint", team: .blueTeam, player: .spymaster, delay: 1.0),
        Message(text: "that helps them to learn what are their words", team: .blueTeam, player: .spymaster, delay: 1.5),
        Message(text: "She can group her words:", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "drag-and-drop to move", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "double-tap to separate", team: .redTeam, player: .spymaster, delay: 1.0),
        Message(text: "And she come up with a hint that combines some of them", team: .redTeam, player: .spymaster, delay: 1.5),
        Message(text: "First 3 words in our case", team: .redTeam, player: .spymaster, delay: 1.5),
        Message(text: "Than she tells her operatives this hint", team: .blueTeam, player: .spymaster, delay: 1.0),
        Message(text: "and a number showing how many words are combined", team: .blueTeam, player: .spymaster, delay: 1.5),
        Message(text: "Operatives choose what words suit better", team: .redTeam, player: .operatives, delay: 1.5),
        Message(text: "They can guess no more than the number of words Spymaster combined", team: .blueTeam, player: .operatives, delay: 1.5),
        Message(text: "plus one", team: .blueTeam, player: .operatives, delay: 1.5),
        Message(text: "And they stop guessing as soon as", team: .redTeam, player: .operatives, delay: 1.5),
        Message(text: "they make a mistake", team: .redTeam, player: .operatives, delay: 1.5),
        Message(text: "After that another Spymaster", team: .blueTeam, player: .spymaster, delay: 1.0),
        Message(text: "makes his turn", team: .blueTeam, player: .spymaster, delay: 1.5),
        Message(text: "The game ends when one team", team: .redTeam, player: .operatives, delay: 1.0),
        Message(text: "guess all its words", team: .redTeam, player: .operatives, delay: 1.5),
        Message(text: "This team is a winner", team: .redTeam, player: .spymaster, delay: 1.5),
        Message(text: "Or", team: .blueTeam, player: .operatives, delay: 0.5),
        Message(text: "The game ends if one team", team: .blueTeam, player: .operatives, delay: 1.0),
        Message(text: "guess the bomb!", team: .blueTeam, player: .operatives, delay: 1.5),
        Message(text: "That team is a looser", team: .blueTeam, player: .spymaster, delay: 1.5),
        Message(text: "Good luck!", team: .redTeam, player: .spymaster)
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
        static let skipAlert = 1.5
    }
    static let picker = [
        Team.redTeam: 2,
        Team.blueTeam: 7
    ]
}

extension MainVC {
    /*func tutorial() {
        leftButtonState = .tutorial
        T.startTutorialTime = Date()
        print(T.startTutorialTime)
        for (i,m) in T.messages.enumerated() {
            Timer.scheduledTimer(withTimeInterval: T.totalDelayBefore[i], repeats: false) { timer in
                self.chatView.add(m)
                }
        }
    }*/
    func tutorial() {
        leftButtonState = .tutorial
        titleBar.text = "How it works?"
        game = Game(isTutorial: true)
        game.delegate = self
        T.prevTutorialTime = Date()
        T.messageNumber = 0
        chatView.add(T.messages[0])
    }
    func showNextMessage() {
        T.messageNumber+=1
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
            //revealCardsColors(color: .red)
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
        case 19:
            wordsTVC.moveRow(at: 3, to: 0)
        case 20:
            wordsTVC.moveRow(at: 2, to: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.wordsTVC.moveRow(at: 8, to: 2)
            })
        case 21:
            wordsTVC.insertRow(card: Card(text: "", color: .neutral), at: 3)
        case 26:
            performSegue(withIdentifier: "toEnterHintVC", sender: leftButton)
        case 28:
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.pressed(uicard: self.uicards[1])
            }
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                self.pressed(uicard: self.uicards[23])
            }
        case 30:
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                self.pressed(uicard: self.uicards[3])
            }
        case 31:
            nextTurn()
        case 32:
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.nextTurn()
                self.performSegue(withIdentifier: "toEnterHintVC", sender: self.leftButton)
            }
        case 34:
            for (i,number) in T.lastSixRedCardsNums.enumerated() {
                Timer.scheduledTimer(withTimeInterval: T.Delay.betweenCards*Double(i), repeats: false) { _ in
                    self.pressed(uicard: self.uicards[number])
                }
            }
        case 38:
            uicards[10].cover()
        case T.messages.count:
            leftButtonState = .newGame
        default: ()
        }
    }
}
