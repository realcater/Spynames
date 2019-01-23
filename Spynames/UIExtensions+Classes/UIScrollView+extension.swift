import UIKit

extension UIScrollView {
    func scrollToBottomIfNeeded() {
        if contentSize.height - bounds.size.height > 0 {
            let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
