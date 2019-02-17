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

class Card {
    var word: String
    var color: CardColor
    var guessed: Bool
    init(text: String, color: CardColor) {
        self.word = text
        self.color = color
        self.guessed = false
    }
}
