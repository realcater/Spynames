import UIKit

class ChatView: UIScrollView {
    var messages: [Message] = []
    var offsetY : CGFloat = 0
    
    func add(_ message: Message) {
        messages.append(message)
        
        let messageOnTheLeft = (message.playerType == .operatives)
        let text = message.text
        let color = (message.team == .red) ? K.Colors.redDarker : K.Colors.blueNormal
        showMessage(messageOnTheLeft: messageOnTheLeft, text: text, color: color)
    }

    func showMessage(messageOnTheLeft: Bool, text: String, color: UIColor) {
        let label =  UILabel()
        label.numberOfLines = 0
        label.font = K.Fonts.chat
        label.textColor = .white
        label.text = text
        
        let constraintRect = CGSize(width: K.Sizes.Chat.widthUsePerc * self.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: label.font],
                                            context: nil)
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleImageSize = CGSize(width: label.frame.width + K.Sizes.Chat.border.width,
                                     height: label.frame.height + K.Sizes.Chat.border.height)
        
        let x: CGFloat = messageOnTheLeft ? K.Sizes.Chat.margin : self.bounds.width - bubbleImageSize.width - K.Sizes.Chat.margin
        let messageView = UIImageView(frame:
            CGRect(x: x,
                   y: offsetY,
                   width: bubbleImageSize.width,
                   height: bubbleImageSize.height))
        
        offsetY += bubbleImageSize.height + K.Sizes.Chat.vertSpace
        if offsetY > self.contentSize.height {
            self.contentSize.height = offsetY
        }
        
        let imageName = messageOnTheLeft ? K.FileNames.bubbleReceived : K.FileNames.bubbleSent
        let bubbleImage = UIImage(named: imageName)?
            .resizableImage(withCapInsets: UIEdgeInsets(top: K.Sizes.Chat.inset.height, left: K.Sizes.Chat.inset.width, bottom: K.Sizes.Chat.inset.height, right: K.Sizes.Chat.inset.width),
                            resizingMode: .stretch)
            .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        messageView.image = bubbleImage
        messageView.tintColor = color
        
        self.addSubview(messageView)
        label.center = messageView.center
        self.addSubview(label)
    }
}
