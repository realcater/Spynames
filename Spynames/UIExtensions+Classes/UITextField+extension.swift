import UIKit

extension UITextField {
    func addLettersOneByOne(text: String, inDuration duration: Double) {
        let delay = duration / Double(text.count)
        for i in 0..<text.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay*Double(i),
                                          execute: {
                                            self.text = self.text! + String(text[i])
            })
        }
    }
}
