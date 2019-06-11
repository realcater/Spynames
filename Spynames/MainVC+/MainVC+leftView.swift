import UIKit

extension MainVC {
    func addTapsForLeftView() {
        addTaps(for: leftView,
                singleTapAction: #selector(leftViewSingleTap),
                leftSwipeAction: #selector(leftViewSwipedLeft),
                rightSwipeAction: #selector(leftViewSwipedRight))
    }
    @objc func leftViewSwipedLeft(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            collapseLeftView()
        }
    }
    @objc func leftViewSingleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            restoreLeftView()
        }
    }
    @objc func leftViewSwipedRight(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            restoreLeftView()
        }
    }
    func collapseLeftView() {
        if leftViewShown {
            view.getConstraint(named: "leftViewShift")?.constant = K.SideView.Left.shiftWhenHidden
            UIView.animate(withDuration: K.SideView.animationLength, delay: 0, animations: {
                self.mainView.zoomScale = 1.0
                self.view.layoutIfNeeded()
            })
            for uicard in self.uicards {
                uicard.redraw(withDuration: K.SideView.animationLength, redrawMode: .changeSize)
            }
            leftViewShown = false
        }
    }
    func restoreLeftView() {
        if !leftViewShown {
            view.getConstraint(named: "leftViewShift")?.constant = 0
            UIView.animate(withDuration: K.SideView.animationLength, delay: 0, animations: {
                self.mainView.zoomScale = 1.0
                self.view.layoutIfNeeded()
            })
            for uicard in self.uicards {
                uicard.redraw(withDuration: K.SideView.animationLength, redrawMode: .changeSize)
            }
            leftViewShown = true
        }
    }
}
