enum Team {
    case red
    case blue
}

enum WordColor {
    case red
    case blue
    case neutral
    case black
}

enum PlayerType {
    case spymaster
    case operatives
}

class Hint {
    var text: String = ""
    var qty: Int = 1
}

struct Word {
    var text: String
    var color: WordColor
}

func toWordColor(_ team: Team) -> WordColor {
    return (team == .red) ? .red : .blue
}

class Game {
    var words: [Word]
    var currentTeam: Team
    var hints = [Team: [Hint]]()
    var leftWords = [Team: Int]()
    
    init() {
        hints = [.red: [], .blue: []]
        currentTeam = .red
        leftWords = [.red: 9, .blue: 8]
        words = [
            Word(text: "Гриф", color: toWordColor(currentTeam)),
            Word(text: "Дракон-и-дракон", color: toWordColor(currentTeam)),
            Word(text: "Образование", color: toWordColor(currentTeam)),
            Word(text: "Учитель", color: toWordColor(currentTeam)),
            Word(text: "Подъём", color: toWordColor(currentTeam)),
            Word(text: "Метрика", color: toWordColor(currentTeam)),
            Word(text: "Америка", color: toWordColor(currentTeam)),
            Word(text: "Горн", color: toWordColor(currentTeam)),
            Word(text: "Вспышка", color: toWordColor(currentTeam)),
            Word(text: "Бублик", color: .black)
            ]
    }
}
