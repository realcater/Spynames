import UIKit

extension CGRect {
    func moved(x: CGFloat = 0, y: CGFloat = 0) -> CGRect {
        let frame = CGRect(x: origin.x + x,
                              y: origin.y + y,
                              width: width,
                              height: height)
        return frame
    }
}
