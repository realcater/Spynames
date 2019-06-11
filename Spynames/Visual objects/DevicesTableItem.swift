import UIKit

enum DeviceConnectStatus {
    case you
    case joined
    case waited
}

class DevicesTableItem {
    var id: String
    var isMyDevice: Bool
    var role: [Player]
    var label: UILabel
    var iconImageView: UIImageView
    var statusImageView: UIImageView
    var index: Int
    var status: DeviceConnectStatus! {
        didSet {
            self.statusImageView.image = UIImage(named: K.FileNames.deviceConnectStatus[status]!)
            if status == .waited {
                statusImageView.rotate(duration: K.Delays.clockTurnAround)
            } else {
                statusImageView.stopRotating()
            }
        }
    }
    
    var color: UIColor? {
        get {
            return (index % 2) == 1 ? K.Colors.team[.redTeam] : K.Colors.team[.blueTeam]
        }
    }
    init(id: String? = nil, index: Int, isMyDevice: Bool = false, role: [Player], iconImage: UIImage, label: UILabel, iconImageView: UIImageView, statusImageView: UIImageView, labelText: String) {
        if let id = id {
            self.id = id }
        else {
            self.id = Helper.randomString(length: K.idLength)
        }
        self.index = index
        self.isMyDevice = isMyDevice
        self.role = role
        self.iconImageView = iconImageView
        self.statusImageView = statusImageView
        self.label = label
        
        self.iconImageView.image = iconImage
        self.iconImageView.tintColor = color
        self.statusImageView.tintColor = color
        
        self.label.backgroundColor = .clear
        self.label.text = labelText
        
        if let color = color {
            self.label.textColor = color
        } else {
            self.label.makeDoubleColor(topColor: K.Colors.redDarker, bottomColor: K.Colors.blueDarker)
        }
        

        refreshStatusFromServer()
    }
    
    func refreshStatusFromServer() {
        self.status = isMyDevice ? .you : .waited
    }
}
