import UIKit

struct Place {
    var x: Int
    var y: Int
}

protocol AllCardsActionsDelegate: class {
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
    weak var delegate: AllCardsActionsDelegate?
    
    func changeShowColor(fade: Bool) {
        showColor = !showColor
        redraw(fade: fade)
    }
    
    init(place: Place, card: Card, showDelay: Double? = nil, in view: UIView) {
        self.place = place
        self.card = card
        self.view = view
        self.showDelay = showDelay ?? 0.0
        showColor = false
        guessed = false
        
        addButton()
        redraw()
        addRecognizers()
    }
    @objc func singleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            delegate?.changeCardsColorVisibility(fade: false)
        }
    }
    @objc func longPress(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            flip()
        }
    }
    func flip() {
        guessed = !guessed
        redraw()
    }
    
    private func addButton() {
        let (frameStart, pointFinish) = frameCalculate(viewSize: view.frame.size)
        button = UIRoundedButton(frame: frameStart)
        button.makeRounded(cornerRadius: K.Sizes.cardsCornerRadius)
        button.addShadow()
        button.titleLabel?.font = K.Fonts.cardText
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: K.Sizes.Cards.inset, bottom: 0, right: K.Sizes.Cards.inset)
        view.addSubview(button)
        if K.CardsAnimation.show {
            button.animate(move: pointFinish, withDuration: K.CardsAnimation.duration, withDelay: showDelay, forTurns: K.CardsAnimation.turns)
        }
    }
    private func redraw(fade: Bool = false) {
        let cardColor = (!showColor && !guessed) ? CardColor.neutral : card.color
        let title = guessed ? "" : card.word
        let image = guessed ? UIImage(named: K.FileNames.cardBackgroundImage[cardColor]!) : nil
        let duration = fade ? K.Durations.fadeTimeAppearCard : 0.0
        
        UIView.animate(withDuration: duration, animations: {
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
    private func addRecognizers() {
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTapRecognizer.numberOfTapsRequired = 1
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        button.addGestureRecognizer(singleTapRecognizer)
        button.addGestureRecognizer(longPressRecognizer)
    }
    private func frameCalculate(viewSize: CGSize) -> (CGRect, CGPoint) {
        let ttlRelativeWidth = K.Sizes.Cards.marginX * 2 + Double(K.Game.sizeX) + Double(K.Game.sizeX-1)*K.Sizes.Cards.distX
        let width = viewSize.width / CGFloat(ttlRelativeWidth)
        let ttlRelativeHeight = K.Sizes.Cards.marginTop + K.Sizes.Cards.marginBottom + Double(K.Game.sizeY) + Double(K.Game.sizeY-1)*K.Sizes.Cards.distY
        let height = viewSize.height / CGFloat(ttlRelativeHeight)
        let marginX = CGFloat(K.Sizes.Cards.marginX) * width
        let marginTop = CGFloat(K.Sizes.Cards.marginTop) * height

        let pointFinish = CGPoint(
            x: marginX + width * CGFloat(1+K.Sizes.Cards.distX)*CGFloat(place.x),
            y: marginTop + height * CGFloat(1+K.Sizes.Cards.distY)*CGFloat(place.y)
        )
        
        let originX = K.CardsAnimation.show ? K.Sizes.Cards.startPoint.x : pointFinish.x
        let originY = K.CardsAnimation.show ? K.Sizes.Cards.startPoint.y : pointFinish.y

        let frameStart = CGRect(x: originX, y: originY, width: width, height: height)
        
        return (frameStart, pointFinish)
    }
}
