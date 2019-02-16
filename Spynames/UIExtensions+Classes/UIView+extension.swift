import UIKit
import AVFoundation

extension UIView {
    func makeAllButtonsRound(cornerRadius:  CGFloat? = nil, color: UIColor? = nil, font: UIFont? = nil, sound: AVAudioPlayer? = nil) {
        for case let button as UIRoundedButton in self.subviews {
            button.makeRounded(cornerRadius: cornerRadius, color: color, font: font, sound: sound)
        }
    }
    func makeAllSubviewsRound(cornerRadius:  CGFloat? = nil) {
        for subview in self.subviews {
            subview.makeRounded(cornerRadius: cornerRadius)
        }
    }
    func setForAllImages(tintColor: UIColor) {
        for case let imageView as UIImageView in self.subviews {
            imageView.tintColor = tintColor
        }
    }
    func setForAllLabels(withFontName fontName: String, fontSize: CGFloat) {
        for case let label as UILabel in self.subviews {
            if label.font.fontName == fontName {
                label.font = UIFont(descriptor: label.font.fontDescriptor, size: fontSize)
            }
        }
    }
    func setConstraint(identifier: String, size: CGFloat) {
        for constraint in self.constraints {
            if constraint.identifier == identifier {
                constraint.constant = size
            }
        }
    }
    func setBackgroundImage(named: String, alpha: CGFloat, tintColor: UIColor? = nil, contentMode: UIView.ContentMode = .scaleAspectFill) {
        if let image = UIImage(named: named) {
            let backgroundImageView = UIImageView(frame: self.bounds)
            backgroundImageView.image = image
            backgroundImageView.contentMode = contentMode
            backgroundImageView.alpha = alpha
            if let tintColor = tintColor {
                backgroundImageView.tintColor = tintColor
            }
            insertSubview(backgroundImageView, at: 0)
        }
    }
    private static let kRotationAnimationKey = "rotationanimationkey"
    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    @objc func makeDoubleColor(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0, 0.5, 0.5, 1.0]
        gradientLayer.colors = [topColor.cgColor, topColor.cgColor,
                                bottomColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        layer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func makeDoubleColor(leftColor: UIColor, rightColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0, 0.5, 0.5, 1.0]
        gradientLayer.colors = [leftColor.cgColor, leftColor.cgColor,
                                rightColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        layer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func makeRounded(cornerRadius:  CGFloat? = nil) {
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        } else {
            layer.cornerRadius = 0.5 * self.bounds.size.height
        }
    }
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
    }
    func animate(moveTo: CGPoint? = nil, move: CGPoint = CGPoint(x: 0, y: 0),
                 extend: CGSize? = nil,
                 withDuration duration: Double? = nil, withDelay delay: Double? = nil, forTurns turnsQty: Double? = nil) {
        let duration = duration ?? 0.0
        let delay = delay ?? 0.0
        var newOrigin: CGPoint
        if let moveTo = moveTo {
            newOrigin = moveTo
        } else {
            newOrigin = CGPoint(x: frame.origin.x + move.x,
                                    y: frame.origin.y + move.y)
        }
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.frame.origin = newOrigin
            if let extend = extend {
                self.frame.size.width += extend.width
                self.frame.size.height += extend.height
            }
        }, completion: nil)
        
        if let turnsQty = turnsQty, turnsQty > 0 {
            let sectorsQty = 24.0 //smoothness coefficients
            let overlapDurationK = 2.0 //smoothness coefficients, >=1.0
            
            for i in 0..<Int(sectorsQty*turnsQty) {
                let angle = CGFloat(i % Int(sectorsQty)+1)*CGFloat.pi*2.0/CGFloat(sectorsQty)
                UIView.animate(withDuration: duration/sectorsQty/turnsQty*overlapDurationK, delay: delay+Double(i)*duration/sectorsQty/turnsQty, animations: {
                    self.transform = CGAffineTransform(rotationAngle: angle)
                }, completion: nil)
            }
        }
    }
}
