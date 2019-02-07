import UIKit

struct Place {
    var x: Int
    var y: Int
}

class UICard {
    var place: Place
    var card: Card
    var showColor: Bool
    var button: UIRoundedButton!
    
    init(place: Place, card: Card) {
        self.place = place
        self.card = card
        showColor = true
        
    }
    func add(to view: UIView) {
        let frame = frameCalculate(viewSize: view.frame.size)
        button = UIRoundedButton(frame: frame)
        let cardColor = showColor ? card.color : CardColor.neutral
        button.makeRounded(cornerRadius: K.Sizes.cardsCornerRadius, color: K.Colors.cardBackground[cardColor], textColor: K.Colors.cardText[cardColor])
        button.addShadow()
        button.setTitle(card.word, for: .normal)
        button.titleLabel?.font = K.Fonts.cardText
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: K.Sizes.Cards.inset, bottom: 0, right: K.Sizes.Cards.inset)
        view.addSubview(button)
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
