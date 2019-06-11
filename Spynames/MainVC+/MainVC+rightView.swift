import UIKit

extension MainVC {
    func addTapsForRightView() {
        addTaps(for: rightView,
            singleTapAction: #selector(rightViewSingleTap),
            leftSwipeAction: #selector(rightViewSwipedLeft),
            rightSwipeAction: #selector(rightViewSwipedRight))
    }
    @objc func rightViewSwipedRight(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            collapseRightView()
        }
    }
    @objc func rightViewSingleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            restoreRightView()
        }
    }
    @objc func rightViewSwipedLeft(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            restoreRightView()
        }
    }
    func collapseRightView() {
        if rightViewShown {
            view.getConstraint(named: "rightViewShift")?.constant = K.SideView.Right.shiftWhenHidden
            UIView.animate(withDuration: K.SideView.animationLength, delay: 0, animations: {
                self.mainView.zoomScale = 1.0
                self.view.layoutIfNeeded()
            })
            for uicard in self.uicards {
                uicard.redraw(withDuration: K.SideView.animationLength, redrawMode: .changeSize)
            }
            rightViewShown = false
        }
    }
    func restoreRightView() {
        if !rightViewShown {
            view.getConstraint(named: "rightViewShift")?.constant = 0
            UIView.animate(withDuration: K.SideView.animationLength, delay: 0, animations: {
                self.mainView.zoomScale = 1.0
                self.view.layoutIfNeeded()
            })
            for uicard in self.uicards {
                uicard.redraw(withDuration: K.SideView.animationLength, redrawMode: .changeSize)
            }
            rightViewShown = true
        }
    }
}
