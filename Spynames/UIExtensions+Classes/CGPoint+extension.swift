import UIKit

public extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    static prefix func -(point: CGPoint) -> CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }
    func toCGSize() -> CGSize {
        return CGSize(width: self.x, height: self.y)
    }
}
