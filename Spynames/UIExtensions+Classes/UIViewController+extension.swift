//
//  UIViewController+extension.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 31.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

extension UIViewController {
    func addTaps(for tappedView: UIView? = nil, singleTapAction: Selector? = nil, doubleTapAction: Selector? = nil, leftSwipeAction: Selector? = nil, rightSwipeAction: Selector? = nil) {
        let tappedView: UIView = tappedView ?? self.view //if ==nil than we use default view of VC
        var singleTap: UITapGestureRecognizer!
        var doubleTap: UITapGestureRecognizer!
        var leftSwipe: UISwipeGestureRecognizer!
        var rightSwipe: UISwipeGestureRecognizer!
        
        if let singleTapAction = singleTapAction {
            singleTap = UITapGestureRecognizer(target: self, action: singleTapAction)
            singleTap.numberOfTapsRequired = 1
        }
        if let doubleTapAction = doubleTapAction {
            doubleTap = UITapGestureRecognizer(target: self, action: doubleTapAction)
            doubleTap.numberOfTapsRequired = 2
        }
        if let leftSwipeAction = leftSwipeAction {
            leftSwipe = UISwipeGestureRecognizer(target: self, action: leftSwipeAction)
            leftSwipe.direction = .left
        }
        if let rightSwipeAction = rightSwipeAction {
            rightSwipe = UISwipeGestureRecognizer(target: self, action: rightSwipeAction)
            rightSwipe.direction = .right
        }
        if let singleTap = singleTap, let doubleTap = doubleTap  {
            singleTap.require(toFail: doubleTap)
        }
        
        if let singleTap = singleTap { tappedView.addGestureRecognizer(singleTap) }
        if let doubleTap = doubleTap { tappedView.addGestureRecognizer(doubleTap) }
        if let leftSwipe = leftSwipe { tappedView.addGestureRecognizer(leftSwipe) }
        if let rightSwipe = rightSwipe { tappedView.addGestureRecognizer(rightSwipe) }
        
        tappedView.isUserInteractionEnabled = true
    }
}
