enum Team {
    case red
    case blue
}

enum PlayerType {
    case spymaster
    case operatives
}

class Message {
    var text: String
    var team: Team
    var playerType: PlayerType
    var wordsQty: Int?
    
    init(text: String, team: Team, player: PlayerType) {
        self.text = text
        self.team = team
        self.playerType = player
    }
}
