import UIKit
import AVFoundation

class UIChatView: UIScrollView {
    private var offsetY : CGFloat = 0
    
    //parameters set in setup() with default values
    var font: UIFont? = nil
    var vertSpace: CGFloat = 8 //a space between messages
    var inset = CGSize(width: 20, height: 10) // internal space between text and bubble
    var corner = CGSize(width: 21, height: 17) // rounded corner size, should correspond to the bubble image
    var widthUsePerc: CGFloat = 0.66 //Percentage of width used for messages
    var indent: CGFloat = 8 //left and right indent to the bubbles
    var bubbleSentFileName: String = "bubbleSent"
    var bubbleReceivedFileName: String = "bubbleReceived"
    var sound: AVAudioPlayer? = nil
    
    func setup(font: UIFont? = nil, vertSpace: CGFloat? = nil, border: CGSize? = nil, inset: CGSize? = nil, widthUsePerc: CGFloat? = nil, margin: CGFloat? = nil, bubbleSentFileName: String? = nil, bubbleReceivedFileName: String? = nil, sound: AVAudioPlayer? = nil) {
        if let font = font { self.font = font }
        if let vertSpace = vertSpace { self.vertSpace = vertSpace }
        if let border = border { self.inset = border }
        if let inset = inset { self.corner = inset }
        if let widthUsePerc = widthUsePerc { self.widthUsePerc = widthUsePerc }
        if let margin = margin { self.indent = margin }
        if let bubbleSentFileName = bubbleSentFileName { self.bubbleSentFileName = bubbleSentFileName }
        if let bubbleReceivedFileName = bubbleReceivedFileName { self.bubbleReceivedFileName = bubbleReceivedFileName }
        if let sound = sound { self.sound = sound }
    }

    func showMessage(messageOnTheLeft: Bool, text: String, color: UIColor, shadowColor: UIColor? = nil, shadowOpacity: Float = 0.5) {
        let label =  UILabel()
        label.numberOfLines = 0
        if let font = font { label.font = font }
        label.textColor = .white
        label.text = text
        
        let constraintRect = CGSize(width: widthUsePerc * self.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: label.font],
                                            context: nil)
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleImageSize = CGSize(width: label.frame.width + inset.width,
                                     height: label.frame.height + inset.height)
        
        let x: CGFloat = messageOnTheLeft ? indent : self.bounds.width - bubbleImageSize.width - indent
        let bubbleImageView = UIImageView(frame:
            CGRect(x: x,
                   y: offsetY,
                   width: bubbleImageSize.width,
                   height: bubbleImageSize.height))
        
        offsetY += bubbleImageSize.height + vertSpace
        if offsetY > self.contentSize.height {
            self.contentSize.height = offsetY
            
        }
        
        let imageName = messageOnTheLeft ? bubbleReceivedFileName : bubbleSentFileName
        let bubbleImage = UIImage(named: imageName)?
            .resizableImage(withCapInsets: UIEdgeInsets(top: corner.height, left: corner.width, bottom: corner.height, right: corner.width),
                            resizingMode: .stretch)
            .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        bubbleImageView.image = bubbleImage
        bubbleImageView.tintColor = color
        
        if let shadowColor = shadowColor {
            bubbleImageView.addShadow(color: shadowColor, opacity: shadowOpacity)
        }
        self.addSubview(bubbleImageView)
        label.center = bubbleImageView.center
        self.addSubview(label)
        self.scrollToBottomIfNeeded()
        sound?.play()
    }
    func clear() {
        setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        for view in subviews {
            view.removeFromSuperview()
        }
        offsetY = 0
        contentSize.height = 0
    }
}
