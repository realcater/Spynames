enum Team {
    case red
    case blue
}

enum Player {
    case spymaster
    case operatives
}

class Message {
    var text: String
    var team: Team
    var player: Player
    var wordsQty: Int?
    
    init(text: String, team: Team, player: Player) {
        self.text = text
        self.team = team
        self.player = player
    }
}
