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
        showColor = false
        
    }
    func add(to view: UIView) {
        let frame = frameCalculate(viewSize: view.frame.size)
        button = UIRoundedButton(frame: frame)
        view.addSubview(button)
    }
    
    private func frameCalculate(viewSize: CGSize) -> CGRect {
        let width = viewSize.width / CGFloat(K.Sizes.Cards.marginX*2 + Double(K.Game.sizeX) + Double(K.Game.sizeX-1)*K.Sizes.Cards.distX)
        let height = viewSize.height / CGFloat(K.Sizes.Cards.marginY*2 + Double(K.Game.sizeY) + Double(K.Game.sizeY-1)*K.Sizes.Cards.distY)
        let marginX = CGFloat(K.Sizes.Cards.marginX) * width
        let marginY = CGFloat(K.Sizes.Cards.marginY) * height
        let frame = CGRect(x: marginX + width * CGFloat(place.x),
                      y: marginY + height * CGFloat(place.y),
                      width: width,
                      height: height)
        return frame
    }
    
}
