import Foundation

enum Team: CaseIterable {
    case redTeam
    case blueTeam
    
    func toCardColor() -> CardColor {
        return (self == .redTeam) ? CardColor.red : CardColor.blue
    }
    func next() -> Team {
        return self == .redTeam ? .blueTeam : .redTeam
    }
    func getDescription() -> String {
        return (self == .redTeam) ? K.Labels.redText : K.Labels.blueText
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
    func next() -> PlayerType {
        return self == .spymaster ? .operatives : .spymaster
    }
    func getDescription() -> String {
        return (self == .spymaster) ? K.Labels.spymasterText : K.Labels.operativesText
    }
}

struct Player: Hashable {
    var team: Team
    var type: PlayerType
    /*init(team: Team, type: PlayerType) {
        self.team = team
        self.type = type
    }*/
    func next() -> Player {
        switch type {
        case .spymaster: return Player(team: team, type: type.next())
        case .operatives: return Player(team: team.next(), type: type.next())
        }
        
    }
}
class Hint: NSCopying {
    var text: String = ""
    var qty: Int = 1

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Hint()
        copy.qty = qty
        copy.text = text
        return copy
    }
}

protocol GameDelegate: class {
    func setCardGuessed(card: Card)
}

class Card {
    var word: String
    var color: CardColor
    private var _guessed: Bool
    weak var delegate: GameDelegate?
    var guessed: Bool {
        set {
            if newValue && !_guessed {
                _guessed = newValue
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
