import UIKit

enum DeviceRoles {
    case redSpymaster
    case blueSpymaster
    case redOperatives
    case blueOperatives
}

enum DeviceConnectStatus {
    case you
    case joined
    case waited
}

class Device {
    var role: DeviceRoles
    var label: UILabel
    var image: UIImageView
    var statusImage: UIImageView
    var status: DeviceConnectStatus! {
        didSet {
            self.statusImage.image = UIImage(named: K.imageForDeviceConnectStatus[status]!)
            if status == .waited {
                statusImage.rotate(duration: K.Durations.clockTurnAround)
            } else {
                statusImage.stopRotating()
            }
        }
    }
    
    init(role: DeviceRoles, label: UILabel, image: UIImageView, statusImage: UIImageView) {
        self.role = role
        self.label = label
        self.image = image
        self.statusImage = statusImage
        self.label.backgroundColor = .clear
        self.label.textColor = K.Colors.forRole[role]
        self.image.tintColor = K.Colors.forRole[role]
        self.statusImage.tintColor = K.Colors.forRole[role]
        refreshStatusFromServer()
    }
    
    func refreshStatusFromServer() {
        self.status = (role == .redSpymaster) ? .you : .waited
    }
}
