enum Team: CaseIterable {
    case redTeam
    case blueTeam
    
    func toCardColor() -> CardColor {
        return (self == .redTeam) ? CardColor.red : CardColor.blue
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

protocol CardGuessedDelegate: class {
    func setCardGuessed(card: Card)
}

class Card {
    var word: String
    var color: CardColor
    private var _guessed: Bool
    weak var delegate: CardGuessedDelegate?
    var guessed: Bool {
        set {
            _guessed = newValue
            if _guessed {
                delegate?.setCardGuessed(card: self)
            }
        }
        get {
            return _guessed
        }
    }
    init(text: String, color: CardColor) {
        self.word = text
        self.color = color
        self._guessed = false
    }
    
}
