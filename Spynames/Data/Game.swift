import AVFoundation

class Game {
    var cards = [Card]()
    var leftCardsOf = [CardColor: [Card]]()
    var startTeam: Team
    var currentPlayer: Player
    var hints: [Team: [Hint]] = [.redTeam: [], .blueTeam: []]
    var guessedThisTurn : Int = 0
    var canGuessMore = true
    weak var delegate: MainVCGameDelegate?
    var devicesQty: Int
    var activeDeviceIndex: Int
    var personalList: [Team: [Card]] = [.redTeam: [], .blueTeam: []]
    var showLegend = true
    var isOver = false
    var isTutorial: Bool
    var sizeX, sizeY: Int

    init(isTutorial: Bool = false) {
        startTeam = .redTeam
        currentPlayer = Player(team: .redTeam, type: .spymaster)
        devicesQty = 1
        activeDeviceIndex = 0
        self.isTutorial = isTutorial
        sizeX = isTutorial ? T.sizeX : K.Game.sizeX
        sizeY = isTutorial ? T.sizeY : K.Game.sizeY
        for color in CardColor.allCases { leftCardsOf[color] = [] }
        generateCards()
        generatePersonalLists()
    }
}

extension Game {
    func nextTurn() {
        currentPlayer = currentPlayer.next()
        canGuessMore = true
        guessedThisTurn = 0
    }
}

private extension Game {
    func generateCards() {
        let cardsColors = isTutorial ? T.tutorialColors : getRandomCardsColors()
        let cardsTexts = isTutorial ? Ru.tutorialWords : Helper.getRandomUnique(from: Ru.words, qty: ttlCardsQty) as! [String]
        
        for (cardText, cardColor) in zip(cardsTexts, cardsColors) {
            let card = Card(text: cardText.capitalizingFirstLetter(), color: cardColor)
            card.delegate = self
            cards.append(card)
            leftCardsOf[cardColor]!.append(card)
            }
    }
    func generatePersonalLists() {
        for card in leftCardsOf[CardColor.red]! {
            personalList[.redTeam]!.append(card)
        }
        for card in leftCardsOf[CardColor.blue]! {
            personalList[.blueTeam]!.append(card)
        }
    }
    func getRandomCardsColors() -> [CardColor] {
        var cardsColors = [CardColor]()
        for color in CardColor.allCases {
            for _ in 0..<cardsQty[color]![startTeam]! {
                cardsColors.append(color)
            }
        }
        return cardsColors.shuffled()
    }
}

extension Game {
    var ttlCardsQty: Int {
        get {
            return sizeX * sizeY
        }
    }
    var startTeamCardsQty: Int {
        get {
            return Int(round(Double(ttlCardsQty)/3))+1
        }
    }
    var secondTeamCardsQty: Int {
        get {
            return Int(round(Double(ttlCardsQty)/3))
        }
    }
    var neutralCardsQty: Int {
        get {
            return ttlCardsQty-startTeamCardsQty-secondTeamCardsQty-1
        }
    }
    var cardsQty: [CardColor: [Team: Int]] {
        get {
            return [
                CardColor.red: [Team.redTeam: startTeamCardsQty, Team.blueTeam: secondTeamCardsQty],
                CardColor.blue: [Team.redTeam: secondTeamCardsQty, Team.blueTeam: startTeamCardsQty],
                CardColor.neutral: [Team.redTeam: neutralCardsQty, Team.blueTeam: neutralCardsQty],
                CardColor.black: [Team.redTeam: 1, Team.blueTeam: 1]
            ]
        }
    }
    var currentPlayerMaxCardsQty: Int {
        get {
            return cardsQty[currentPlayer.team.toCardColor()]![startTeam]!
        }
    }
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
            let redScore = cardsQty[CardColor.red]![startTeam]! - leftCardsOf[.red]!.count
            let blueScore = cardsQty[CardColor.blue]![startTeam]! - leftCardsOf[.blue]!.count
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
            return min(currentHint!.qty - guessedThisTurn+1, currentPlayerMaxCardsQty)
        }
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
        if leftCardsOf[currentPlayer.team.toCardColor()]?.count == 0 {
            delegate?.gameOver(withBomb: false)
        }
    }
}

