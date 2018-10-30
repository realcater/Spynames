import UIKit
import AVFoundation

extension UIView {
    func makeAllButtonsRound(cornerRadius:  CGFloat? = nil, color: UIColor? = nil, sound: AVAudioPlayer? = nil) {
        for case let button as MyButton in self.subviews {
            button.makeRounded(cornerRadius: cornerRadius, color: color, sound: sound)
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
    func setBackgroundImage(named: String, alpha: CGFloat) {
        if let image = UIImage(named: named) {
            let backgroundImageView = UIImageView(frame: self.bounds)
            backgroundImageView.image = image
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.alpha = alpha
            insertSubview(backgroundImageView, at: 0)
        }
    }
    func doubleColor(color1: UIColor, color2: UIColor) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        //gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        //gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        //gradientLayer.locations = [0, 1.0]
        gradientLayer.colors = [color1, color2]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
