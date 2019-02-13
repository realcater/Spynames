import UIKit
import AVFoundation

class UIRoundedButton: UIButton {
    var sound: AVAudioPlayer? = nil

    @objc func playClickSound(_ sender: UIRoundedButton) {
        sound?.play()
    }
    func makeRounded(cornerRadius:  CGFloat? = nil, color: UIColor? = nil, textColor: UIColor? = nil, tintColor: UIColor? = nil, font: UIFont? = nil, sound: AVAudioPlayer? = nil) {
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        } else {
            layer.cornerRadius = 0.5 * self.bounds.size.height
        }
        if let color = color { backgroundColor = color }
        if let textColor = textColor { setTitleColor(textColor, for: .normal) }
        if let tintColor = tintColor { self.tintColor = tintColor }
        if let font = font { titleLabel?.font = font }
        if let sound = sound { turnClickSoundOn(sound: sound) }
    }
    func turnClickSoundOn(sound: AVAudioPlayer?) {
        self.addTarget(self, action: #selector(playClickSound), for: .touchDown)
        self.sound = sound
    }
    func show(color: UIColor, title: String, sound: AVAudioPlayer? = nil) {
        self.setTitle(title, for: .normal)
        backgroundColor = color
        isHidden = false
        if let sound = sound {
            turnClickSoundOn(sound: sound)
        } else {
            self.removeTarget(nil, action: nil, for: .touchDown)
        }
    }
    override func makeDoubleColor(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0, 0.5, 0.5, 1.0]
        gradientLayer.colors = [topColor.cgColor, topColor.cgColor,
                                bottomColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        layer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
        if let imageView = imageView { bringSubviewToFront(imageView) }
    }
    func animate(move: CGPoint, withDuration duration: Double? = nil, withDelay delay: Double? = nil, forTurns turnsQty: Double? = nil) {
        let duration = duration ?? 0.0
        let delay = delay ?? 0.0
        UIView.animate(withDuration: duration, delay: delay, animations: {
                            self.frame.origin = move
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
