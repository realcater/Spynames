import UIKit

struct Place {
    var x: Int
    var y: Int
}

protocol AllCardsActionsDelegate: class {
    func changeCardsColorVisibility()
}

class UICard {
    var place: Place
    var card: Card
    private var _showColor: Bool
    var guessed: Bool
    var button: UIRoundedButton!
    var view: UIView
    weak var delegate: AllCardsActionsDelegate?
    
    var showColor: Bool {
        get {
            return _showColor
        }
        set {
            _showColor = newValue
            redraw()
        }
    }
    
    init(place: Place, card: Card, in view: UIView) {
        self.place = place
        self.card = card
        self.view = view
        _showColor = true
        guessed = false
        
        addButton()
        redraw()
        addRecognizers()
    }
    @objc func singleTap(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            delegate?.changeCardsColorVisibility()
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
        let frame = frameCalculate(viewSize: view.frame.size)
        button = UIRoundedButton(frame: frame)
        button.makeRounded(cornerRadius: K.Sizes.cardsCornerRadius)
        button.addShadow()
        button.titleLabel?.font = K.Fonts.cardText
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: K.Sizes.Cards.inset, bottom: 0, right: K.Sizes.Cards.inset)
        view.addSubview(button)
    }
    private func redraw() {
        let cardColor = (!_showColor && !guessed) ? CardColor.neutral : card.color
        button.backgroundColor = K.Colors.cardBackground[cardColor]![guessed]
        button.setTitleColor(K.Colors.cardText[cardColor], for: .normal)
        button.tintColor = K.Colors.imageColor[cardColor]
        let title = guessed ? "" : card.word
        let image = guessed ? UIImage(named: K.FileNames.cardBackgroundImage[cardColor]!) : nil
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle(title, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    private func addRecognizers() {
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTapRecognizer.numberOfTapsRequired = 1
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        button.addGestureRecognizer(singleTapRecognizer)
        button.addGestureRecognizer(longPressRecognizer)
    }
    private func frameCalculate(viewSize: CGSize) -> CGRect {
        let ttlRelativeWidth = K.Sizes.Cards.marginX * 2 + Double(K.Game.sizeX) + Double(K.Game.sizeX-1)*K.Sizes.Cards.distX
        let width = viewSize.width / CGFloat(ttlRelativeWidth)
        let ttlRelativeHeight = K.Sizes.Cards.marginTop + K.Sizes.Cards.marginBottom + Double(K.Game.sizeY) + Double(K.Game.sizeY-1)*K.Sizes.Cards.distY
        let height = viewSize.height / CGFloat(ttlRelativeHeight)
        let marginX = CGFloat(K.Sizes.Cards.marginX) * width
        let marginTop = CGFloat(K.Sizes.Cards.marginTop) * height
        let frame = CGRect(x: marginX + width * CGFloat(1+K.Sizes.Cards.distX)*CGFloat(place.x),
                      y: marginTop + height * CGFloat(1+K.Sizes.Cards.distY)*CGFloat(place.y),
                      width: width,
                      height: height)
        return frame
    }
}
