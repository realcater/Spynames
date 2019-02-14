enum Team: CaseIterable {
    case red
    case blue
    
    func toCardColor() -> CardColor {
        return (self == .red) ? CardColor.red : CardColor.blue
    }
}

enum CardColor: CaseIterable {
    case red
    case blue
    case neutral
    case black
}

enum PlayerType: CaseIterable {
    case spymaster
    case operatives
}

class Hint {
    var text: String = ""
    var qty: Int = 1
}



class Game {
    var cards = [Card]()
    var cardsOf = [CardColor: [Card]]()
    var startTeam: Team
    var currentTeam: Team
    var hints: [Team: [Hint]] = [.red: [], .blue: []]
    var leftWords = [Team: Int]()
    
    var cardsOfCurrentTeam: [Card] {
        get {
            return cardsOf[currentTeam.toCardColor()]!
        }
    }
    init() {
        startTeam = .red
        currentTeam = .red

        for color in CardColor.allCases { cardsOf[color] = [] }
        leftWords = [.red: K.Game.cardsQty[.red]![startTeam]!,
                     .blue: K.Game.cardsQty[.blue]![startTeam]!]
        
        generateCards()
    }
    
    private func generateCards() {
        let cardsColors = getRandomCardsColors()
        let cardsTexts = Helper.getRandomUnique(from: Ru.words, qty: K.Game.ttlCardsQty) as! [String]
        
        for (cardText, cardColor) in zip(cardsTexts, cardsColors) {
            let card = Card(text: cardText.capitalizingFirstLetter(), color: cardColor)
            cards.append(card)
            cardsOf[cardColor]!.append(card)
            }
    }
    
    private func getRandomCardsColors() -> [CardColor] {
        var cardsColors = [CardColor]()
        for color in CardColor.allCases {
            for _ in 0..<K.Game.cardsQty[color]![startTeam]! {
                cardsColors.append(color)
            }
        }
        return cardsColors.shuffled()
    }
}

