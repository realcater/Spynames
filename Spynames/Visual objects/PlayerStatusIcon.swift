import UIKit

class PlayerStatusIcon {
    var bar: UIView
    var image: UIImageView
    var playerType: PlayerType
    var team: Team
    
    var active: Bool = false {
        didSet {
            if active {
                image.tintColor = online ? UIColor.white : UIColor.gray
                bar.backgroundColor = K.Colors.team[team]!
            } else {
                image.tintColor = online ? K.Colors.team[team]! : UIColor.gray
                bar.backgroundColor = UIColor(white: 1, alpha: 0)
            }
        }
    }
    var online: Bool = true {
        didSet {
            if active {
                image.tintColor = online ? UIColor.white : UIColor.gray
            } else {
                image.tintColor = online ? K.Colors.team[team]! : UIColor.gray
            }
        }
    }
    var blink: Bool = false {
        willSet {
            if newValue != blink {
                switch newValue {
                    case true:
                        bar.startBlink(withDuration: K.Delays.playerStatusIconsBlink)
                        image.startBlink(withDuration: K.Delays.playerStatusIconsBlink)
                    case false:
                        bar.stopBlink()
                        image.stopBlink()
                }
            }
        }
    }
    
    init(playerType: PlayerType, team: Team, bar: UIView, image: UIImageView) {
        self.playerType = playerType
        self.team = team
        self.bar = bar
        self.image = image
        self.image.image = UIImage(named: K.FileNames.playerTypeIcon[playerType]!)
        defer { //we use defer to activate property observers
            self.active = false
            self.online = true
            self.blink = false
        }
    }
}
