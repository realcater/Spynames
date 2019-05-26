import UIKit

class PlayerStatusIcon {
    private var _active: Bool = false
    private var _online: Bool = true
    private var _blink: Bool = false
    var bar: UIView
    var image: UIImageView
    var playerType: PlayerType
    var team: Team
    
    var active: Bool {
        set {
            _active = newValue
            if _active {
                image.tintColor = _online ? UIColor.white : UIColor.gray
                bar.backgroundColor = K.Colors.team[team]!
            } else {
                image.tintColor = _online ? K.Colors.team[team]! : UIColor.gray
                bar.backgroundColor = UIColor(white: 1, alpha: 0)
            }
        }
        get {
            return _active
        }
    }
    var online: Bool {
        set {
            _online = newValue
            if _active {
                image.tintColor = _online ? UIColor.white : UIColor.gray
            } else {
                image.tintColor = _online ? K.Colors.team[team]! : UIColor.gray
            }
        }
        get {
            return _online
        }
    }
    var blink: Bool {
        set {
            if newValue != _blink {
                _blink = newValue
                switch _blink {
                    case true:
                        bar.startBlink(withDuration: K.Delays.playerStatusIconsBlink)
                        image.startBlink(withDuration: K.Delays.playerStatusIconsBlink)
                    case false:
                        bar.stopBlink()
                        image.stopBlink()
                }
            }
        }
        get {
            return _blink
        }
    }
    
    init(playerType: PlayerType, team: Team, bar: UIView, image: UIImageView) {
        self.playerType = playerType
        self.team = team
        self.bar = bar
        self.image = image
        self.image.image = UIImage(named: K.FileNames.playerTypeIcon[playerType]!)
        active = _active
        online = _online
    }
}
