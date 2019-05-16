import UIKit
import AVFoundation

class PlayersChatView: UIChatView {
    var messages: [Message] = []
    
    func setup() {
        setup(font: K.Fonts.chat, vertSpace: K.Sizes.Chat.vertSpace, border: K.Sizes.Chat.border, inset: K.Sizes.Chat.inset, widthUsePerc: K.Sizes.Chat.widthUsePerc, margin: K.Sizes.Chat.margin, bubbleSentFileName: K.FileNames.bubbleSent, bubbleReceivedFileName: K.FileNames.bubbleReceived, sound: K.Sounds.click)
    }
    func add(_ message: Message) {
        messages.append(message)
        let messageOnTheLeft = (message.playerType == .operatives)
        let color = (message.team == .redTeam) ? K.Colors.teamChat[.redTeam]! : K.Colors.teamChat[.blueTeam]!
        showMessage(messageOnTheLeft: messageOnTheLeft, text: message.text, color: color, shadowColor: K.Colors.shadowColor[message.cardColor]!, shadowOpacity: K.Colors.messageShadowOpacity)
     }
}
