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
    
    init(text: String, team: Team, player: PlayerType, textType: TextType = .normal, cardColor: CardColor? = nil) {
        self.text = text
        self.team = team
        self.playerType = player
        self.textType = textType
        self.cardColor = cardColor
    }
}
