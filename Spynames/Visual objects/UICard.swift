import UIKit

struct Place {
    var x: Int
    var y: Int
}

protocol MainVCDelegate: class {
    func changeCardsColorVisibility(fade: Bool)
}

class UICard {
    var place: Place
    var card: Card
    private var showColor: Bool
    var guessed: Bool
    var button: UIRoundedButton!
    var view: UIView
    var showDelay: Double
    weak var mainVCDelegate: MainVCDelegate?
    
    init(place: Place, card: Card, showDelay: Double? = nil, in view: UIView) {
        self.place = place
        self.card = card
        self.view = view
        self.showDelay = showDelay ?? 0.0
        showColor = false
        guessed = false
        
        addButton()
        addRecognizers()
    }
    
    func changeShowColor(fade: Bool) {
        showColor = !showColor
        redraw(withDuration: K.Durations.fadeTimeAppearCard)
    }
    func flip() {
        guessed = !guessed
        redraw()
    }
    
    func drawStartDeal() {
        redraw(inFrame: frameForStartDeal, forDuration: 0)
    }

    func redraw(withDuration duration: Double = 0) {
        redraw(inFrame: frameForPlace, forDuration: duration)
    }
}

private extension UICard {
    func addButton() {
        button = UIRoundedButton(frame: frameForPlace)
        button.makeRounded(cornerRadius: K.Sizes.cardsCornerRadius)
        button.addShadow()
        button.titleLabel?.font = K.Fonts.cardText
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: K.Sizes.Cards.inset, bottom: 0, right: K.Sizes.Cards.inset)
        view.addSubview(button)
        if K.CardsAnimation.show {
            drawStartDeal()
            button.animate(moveTo: originForPlace, withDuration: K.CardsAnimation.duration, withDelay: showDelay, forTurns: K.CardsAnimation.turns)
        } else {
            redraw()
        }
    }
    func redraw(inFrame frame: CGRect, forDuration duration: Double) {
        let cardColor = (!showColor && !guessed) ? CardColor.neutral : card.color
        let title = guessed ? "" : card.word
        let image = guessed ? UIImage(named: K.FileNames.cardBackgroundImage[cardColor]!) : nil
        UIView.animate(withDuration: duration, animations: {
            self.button.frame = frame
            self.button.backgroundColor = K.Colors.cardBackground[cardColor]![self.guessed]
            self.button.setTitleColor(K.Colors.cardText[cardColor], for: .normal)
            self.button.tintColor = K.Colors.imageColor[cardColor]
            
            self.button.setImage(image, for: .normal)
            self.button.imageView?.contentMode = .scaleAspectFit
            self.button.setTitle(title, for: .normal)
            self.button.imageEdgeInsets = UIEdgeInsets(top: K.Sizes.Cards.inset, left: 0, bottom: K.Sizes.Cards.inset, right: 0)
        }
        )
    }
    var frameSize: CGSize {
        get {
            let ttlRelativeWidth = K.Sizes.Cards.marginX * 2 + Double(K.Game.sizeX) + Double(K.Game.sizeX-1)*K.Sizes.Cards.distX
            let width = view.frame.width / CGFloat(ttlRelativeWidth)
            let ttlRelativeHeight = K.Sizes.Cards.marginTop + K.Sizes.Cards.marginBottom + Double(K.Game.sizeY) + Double(K.Game.sizeY-1)*K.Sizes.Cards.distY
            let height = view.frame.height / CGFloat(ttlRelativeHeight)
            return CGSize(width: width, height: height)
        }
    }
    var startFrame: CGRect {
        get {
            let frame = K.CardsAnimation.show ? frameForStartDeal : frameForPlace
            return frame
        }
    }
    var frameForStartDeal: CGRect {
        get {
            return CGRect(x: K.Sizes.Cards.startPoint.x, y: K.Sizes.Cards.startPoint.y, width: frameSize.width, height: frameSize.height)
        }
    }
    var frameForPlace: CGRect {
        let marginX = CGFloat(K.Sizes.Cards.marginX) * frameSize.width
        let marginTop = CGFloat(K.Sizes.Cards.marginTop) * frameSize.height
        let origin = CGPoint(
            x: marginX + frameSize.width * CGFloat(1+K.Sizes.Cards.distX)*CGFloat(place.x),
            y: marginTop + frameSize.height * CGFloat(1+K.Sizes.Cards.distY)*CGFloat(place.y)
        )
        return CGRect(x: origin.x, y: origin.y, width: frameSize.width, height: frameSize.height)
    }
    private var originForPlace: CGPoint {
        return CGPoint(x: frameForPlace.origin.x, y: frameForPlace.origin.y)
    }
}
//MARK: - gesturesReconginizers
extension UICard {
    private func addRecognizers() {
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTapRecognizer.numberOfTapsRequired = 1
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        button.addGestureRecognizer(singleTapRecognizer)
        button.addGestureRecognizer(longPressRecognizer)
    }
    @objc func singleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            mainVCDelegate?.changeCardsColorVisibility(fade: false)
        }
    }
    @objc func longPress(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            flip()
        }
    }
}
