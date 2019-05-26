enum TextType {
    case normal
    case crossed
    case doubleCrossed
}

class Message {
    var text: String
    var team: Team
    var playerType: PlayerType
    var wordsQty: Int?
    var textType: TextType
    var cardColor: CardColor?
    var delay: Double
    
    init(text: String, team: Team, player: PlayerType, textType: TextType = .normal, cardColor: CardColor? = nil, delay: Double = 0) {
        self.text = text
        self.team = team
        self.playerType = player
        self.textType = textType
        self.cardColor = cardColor
        self.delay = delay
    }
}
