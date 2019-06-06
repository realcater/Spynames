import UIKit

enum RedrawMode {
    case dissolve
    case flip
    case changeSize
}
struct Place {
    var x: Int
    var y: Int
}

class UICard {
    var place: Place
    var card: Card
    private var colorIsVisible: Bool
    var button: UIRoundedButton!
    var view: UIView
    var showDelay: Double
    weak var delegate: MainVCUICardDelegate?
    
    var number: Int {
        get {
            return place.y*delegate!.sizeX + place.x
        }
    }
    init(place: Place, card: Card, showDelay: Double? = nil, in view: UIView, delegate: MainVCUICardDelegate) {
        self.place = place
        self.card = card
        self.view = view
        self.showDelay = showDelay ?? 0.0
        self.delegate = delegate
        colorIsVisible = false
        
        addButton()
        addRecognizers()
    }
    
    func showColor(fade: Bool) {
        if colorIsVisible { return }
        colorIsVisible = true
        let duration = fade ? K.Delays.fadeTimeAppearCard : 0.0
        redraw(withDuration: duration)
    }
    func hideColor(fade: Bool) {
        if !colorIsVisible { return }
        colorIsVisible = false
        let duration = fade ? K.Delays.fadeTimeAppearCard : 0.0
        redraw(withDuration: duration)
    }
    func cover(withDuration duration: Double = 0) {
        card.guessed = !card.guessed
        redraw(withDuration: duration)
        delegate?.updateScoreLabels()
        delegate?.updateLeftWordsQtyLabels()
    }
    
    func showWordIfNeeded() {
        if !card.guessed { return }
        redraw(withDuration: 0.5, showWordAnyway: true, redrawMode: .flip)
    }
    func hideWordIfNeeded() {
        if !card.guessed { return }
        redraw(withDuration: 0.5, showWordAnyway: false, redrawMode: .flip)
    }
    func drawStartDeal() {
        redraw(inFrame: frameForStartDeal, forDuration: 0)
    }

    func redraw(withDuration duration: Double = 0, showWordAnyway: Bool = false, redrawMode: RedrawMode = .dissolve) {
        redraw(inFrame: frameForPlace, forDuration: duration, showWordAnyway: showWordAnyway, redrawMode: redrawMode)
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
    func redraw(inFrame frame: CGRect, forDuration duration: Double, showWordAnyway: Bool = false, redrawMode: RedrawMode = .dissolve) {
        let guessed = !showWordAnyway && card.guessed
        let cardColor = (!colorIsVisible && !guessed) ? CardColor.neutral : card.color
        let title = guessed ? "" : card.word
        let transitionOptions: UIView.AnimationOptions = {
            switch redrawMode {
            case .dissolve: return UIView.AnimationOptions.transitionCrossDissolve
            case .flip: return UIView.AnimationOptions.transitionFlipFromTop
            case .changeSize: return UIView.AnimationOptions.allowAnimatedContent
            }
        }()
        let image = guessed ? UIImage(named: K.FileNames.cardBackgroundImage[cardColor]!) : nil
        self.button.imageView?.contentMode = .scaleAspectFit
        self.button.imageEdgeInsets = UIEdgeInsets(top: K.Sizes.Cards.inset, left: 0, bottom: K.Sizes.Cards.inset, right: 0)
        
        UIView.transition(with: self.button, duration: duration,
                          options: [transitionOptions], animations: {
            self.button.frame = frame
            self.button.backgroundColor = K.Colors.cardBackground[cardColor]![guessed]
            self.button.setTitleColor(K.Colors.cardText[cardColor], for: .normal)
            self.button.tintColor = K.Colors.imageColor[cardColor]
            self.button.setImage(image, for: .normal)
            self.button.setTitle(title, for: .normal)
        }, completion: nil)
    }
    var frameSize: CGSize {
        get {
            let ttlRelativeWidth = K.Sizes.Cards.marginX * 2 + Double(delegate!.sizeX) + Double(delegate!.sizeX-1)*K.Sizes.Cards.distX
            let width = view.frame.width / CGFloat(ttlRelativeWidth)
            let ttlRelativeHeight = K.Sizes.Cards.marginTop + K.Sizes.Cards.marginBottom + Double(delegate!.sizeY) + Double(delegate!.sizeY-1)*K.Sizes.Cards.distY
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
        button.addGestureRecognizer(singleTapRecognizer)
    }
    @objc func singleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            delegate?.pressed(uicard: self)
        }
    }
}
