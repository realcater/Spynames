enum Team: CaseIterable {
    case red
    case blue
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

func toCardColor(_ team: Team) -> CardColor {
    return (team == .red) ? .red : .blue
}

class Game {
    var cards = [Card]()
    var cardsOf: [CardColor: [Card]] = [.red: [], .blue: [], .neutral: [], .black: []]
    var startTeam: Team
    var currentTeam: Team
    var hints: [Team: [Hint]] = [.red: [], .blue: []]
    var leftWords = [Team: Int]()
    
    init() {
        startTeam = .red
        currentTeam = .red
        
        leftWords = [.red: K.Game.cardsQty[.red]![startTeam]!,
                     .blue: K.Game.cardsQty[.blue]![startTeam]!]
        
        generateCards()
    }
    
    private func generateCards() {
        let cardsColors = getRandomCardsColors()
        let cardsTexts = Helper.getRandomUnique(from: Ru.words, qty: K.Game.ttlCardsQty) as! [String]
        
        for (cardText, cardColor) in zip(cardsTexts, cardsColors) {
            let card = Card(text: cardText, color: cardColor)
            cards.append(card)
            cardsOf[cardColor]!.append(card)
            }
    }
    
    private func getRandomCardsColors() -> [CardColor] {
        var cardsColors = [CardColor]()
        for cardColorType in CardColor.allCases {
            for _ in 0..<K.Game.cardsQty[cardColorType]![startTeam]! {
                cardsColors.append(cardColorType)
            }
        }
        return cardsColors.shuffled()
    }
}

