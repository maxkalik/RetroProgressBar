//
//  ProgressAnimatedLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/8/23.
//

import UIKit

protocol ProgressAnimatable: CALayer {
    
    func setToWidth(_ width: CGFloat)
    func animateToWidth(_ width: CGFloat,
                        duration: TimeInterval,
                        animationType: CAMediaTimingFunctionName,
                        completion: (() -> Void)?)
}

extension ProgressAnimatable {

    func setToWidth(_ width: CGFloat) {
        removeAllAnimations()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
 
        self.bounds.size.width = width

        CATransaction.commit()
    }
    
    func animateToWidth(_ width: CGFloat,
                        duration: TimeInterval,
                        animationType: CAMediaTimingFunctionName = .easeInEaseOut,
                        completion: (() -> Void)? = nil) {
        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.fromValue = bounds.width
        animation.toValue = width
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: animationType)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.bounds.size.width = width
            completion?()
        }
        
        self.add(animation, forKey: "widthChange")

        CATransaction.commit()
    }
}
