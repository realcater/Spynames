class Game {
    var cards = [Card]()
    var leftCardsOf = [CardColor: [Card]]()
    var startTeam: Team
    var currentPlayer: Player
    var hints: [Team: [Hint]] = [.redTeam: [], .blueTeam: []]
    var guessedThisTurn : Int = 0
    var canGuessMore = true
    weak var delegate: MainVCDelegate?
    var devicesQty: Int
    var activeDeviceIndex: Int
    var personalList: [Team: [Card]] = [.redTeam: [], .blueTeam: []]
    
    var cardsOfCurrentTeam: [Card] {
        get {
            return leftCardsOf[currentPlayer.team.toCardColor()]!
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
    var currentHint: Hint? {
        get {
            return hints[currentPlayer.team]?.last
        }
    }
    var leftToGuessThisTurn: Int {
        if currentHint?.qty == 0 || currentHint?.qty == Int.max {
            return Int.max
        } else {
            return currentHint!.qty - guessedThisTurn+1
        }
    }
    init() {
        startTeam = .redTeam
        currentPlayer = Player(team: .redTeam, type: .spymaster)
        devicesQty = 1
        activeDeviceIndex = 0

        for color in CardColor.allCases { leftCardsOf[color] = [] }
        generateCards()
        generatePersonalLists()
    }
    func nextTurn() {
        currentPlayer = currentPlayer.next()
        canGuessMore = true
        guessedThisTurn = 0
    }
}

private extension Game {
    func generateCards() {
        let cardsColors = getRandomCardsColors()
        let cardsTexts = Helper.getRandomUnique(from: Ru.words, qty: K.Game.ttlCardsQty) as! [String]
        
        for (cardText, cardColor) in zip(cardsTexts, cardsColors) {
            let card = Card(text: cardText.capitalizingFirstLetter(), color: cardColor)
            card.delegate = self
            cards.append(card)
            leftCardsOf[cardColor]!.append(card)
            }
    }
    func generatePersonalLists() {
        for card in (leftCardsOf[CardColor.red]!+leftCardsOf[CardColor.black]!) {
            personalList[.redTeam]!.append(card)
        }
        for card in (leftCardsOf[CardColor.blue]!+leftCardsOf[CardColor.black]!) {
            personalList[.blueTeam]!.append(card)
        }
    }
    func getRandomCardsColors() -> [CardColor] {
        var cardsColors = [CardColor]()
        for color in CardColor.allCases {
            for _ in 0..<K.Game.cardsQty[color]![startTeam]! {
                cardsColors.append(color)
            }
        }
        return cardsColors.shuffled()
    }
}

extension Game: GameDelegate {
    func setCardGuessed(card: Card) {
        if card.color == .black {
            delegate?.gameOver(withBomb: true)
            return
        }
        if let index = leftCardsOf[card.color]!.index(where: {$0 === card}) {
            leftCardsOf[card.color]!.remove(at: index)
            if card.color == currentPlayer.team.toCardColor() {
                delegate?.deleteFromWordsTable(card: card)
            }
            if currentPlayer.team.toCardColor() == card.color {
                guessedThisTurn+=1
                if leftToGuessThisTurn <= 0 { canGuessMore = false }
            } else {
                canGuessMore = false
            }
        }
    }
}

