import UIKit
import AVFoundation

extension UIView {
    func makeAllButtonsRound(cornerRadius:  CGFloat? = nil, color: UIColor? = nil, font: UIFont? = nil, sound: AVAudioPlayer? = nil) {
        for case let button as MyButton in self.subviews {
            button.makeRounded(cornerRadius: cornerRadius, color: color, font: font, sound: sound)
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
    func setBackgroundImage(named: String, alpha: CGFloat, tintColor: UIColor? = nil) {
        if let image = UIImage(named: named) {
            let backgroundImageView = UIImageView(frame: self.bounds)
            backgroundImageView.image = image
            backgroundImageView.contentMode = .scaleAspectFill
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
    func makeDoubleColor(topColor: UIColor, bottomColor: UIColor) {
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
}
