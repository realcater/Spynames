enum Team : Int {
    case red = 1
    case blue = 2
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

struct Hint {
    var text: String
    var qty: Int
}

struct Word {
    var text: String
    var color: WordColor
}

class Game {
    let words: [Word] = [
        Word(text: "Гриф", color: .red),
        Word(text: "Дракон-и-дракон", color: .red),
        Word(text: "Образование", color: .red),
        Word(text: "Учитель", color: .red),
        Word(text: "Подъём", color: .red),
        Word(text: "Метрика", color: .red),
        Word(text: "Америка", color: .red),
        Word(text: "Горн", color: .red),
        Word(text: "Вспышка", color: .red),
        Word(text: "Бублик", color: .black),
    ]
    var currentTeam: Team
    var hints = [Team: [Hint]]()
    var leftWords = [Team: Int]()
    
    init() {
        hints = [.red: [], .blue: []]
        currentTeam = .red
        leftWords = [.red: 9, .blue: 8]
    }
}
