import UIKit

struct Place {
    var x: Int
    var y: Int
}

class UICard {
    var place: Place
    var card: Card
    var showColor: Bool
    var button: UIButton!
    
    init(place: Place, card: Card) {
        self.place = place
        self.card = card
        showColor = false
        
    }
    func add(to view: UIView) {
        viewSize = view.frame.size
        let frame = rectCalculate(viewSize: viewSize)
        button = MyButton(frame: frame)
        view.addSubview(button)
    }
    
    private func rectCalculate(viewSize: CGSize) -> CGRect {
        let width = viewSize.width / CGFloat(K.Sizes.Cards.margin.x*2 + K.Game.sizeX + (K.Game.sizeX-1)*K.Sizes.Cards.dist.x)
        let height = viewSize.height / CGFloat(K.Sizes.Cards.margin.y*2 + K.Game.sizeY + (K.Game.sizeY-1)*K.Sizes.Cards.dist.y) * K.Sizes.Cards.margin.y
        let marginX = K.Sizes.Cards.margin.x * width
        let marginY = K.Sizes.Cards.margin.y * height
        rect = CGRect(x: marginX + width * place.x,
                      y: marginY + height * place.y,
                      width: width,
                      height: height)
    }
    
}
