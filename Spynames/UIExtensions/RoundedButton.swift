import UIKit
import AVFoundation

class RoundedButton: UIButton {
    var sound: AVAudioPlayer? = nil

    @objc func playClickSound(_ sender: RoundedButton) {
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
}
