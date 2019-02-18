class Game {
    var cards = [Card]()
    var leftCardsOf = [CardColor: [Card]]()
    var startTeam: Team
    var currentTeam: Team
    var hints: [Team: [Hint]] = [.redTeam: [], .blueTeam: []]
    weak var delegate: MainVCDelegate?
    
    var cardsOfCurrentTeam: [Card] {
        get {
            return leftCardsOf[currentTeam.toCardColor()]!
        }
    }
    var leftWordsQty: [Team: Int] {
        get {
            let redQty = leftCardsOf[.red]!.count
            let blueQty = leftCardsOf[.blue]!.count
            return [.redTeam: redQty, .blueTeam: blueQty]
        }
    }
    var score: [Team: Int] {
        get {
            let redScore = K.Game.cardsQty[CardColor.red]![startTeam]! - leftCardsOf[.red]!.count
            let blueScore = K.Game.cardsQty[CardColor.blue]![startTeam]! - leftCardsOf[.blue]!.count
            return [.redTeam: redScore, .blueTeam: blueScore]
        }
    }
    init() {
        startTeam = .redTeam
        currentTeam = .redTeam

        for color in CardColor.allCases { leftCardsOf[color] = [] }
        generateCards()
    }
    
    private func generateCards() {
        let cardsColors = getRandomCardsColors()
        let cardsTexts = Helper.getRandomUnique(from: Ru.words, qty: K.Game.ttlCardsQty) as! [String]
        
        for (cardText, cardColor) in zip(cardsTexts, cardsColors) {
            let card = Card(text: cardText.capitalizingFirstLetter(), color: cardColor)
            card.delegate = self
            cards.append(card)
            leftCardsOf[cardColor]!.append(card)
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

extension Game: CardGuessedDelegate {
    func setCardGuessed(card: Card) {
        print("checking card:\(card.word)")
        if let index = leftCardsOf[card.color]!.index(where: {$0 === card}) {
            leftCardsOf[card.color]!.remove(at: index)
            delegate?.deleteCard(at: index)
            print("index=\(index)")
        }
        //leftCardsOf[card.color]!.removeAll{ $0 === card }
        //delegate?.deleteCard(card: card)
    }
}

