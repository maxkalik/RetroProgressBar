//
//  ProgressAnimatedLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/8/23.
//

import UIKit

protocol ProgressAnimatable: CALayer {
    
    /// Sets the layer's width instantly to the specified value.
    func setToWidth(_ width: CGFloat)
    
    /// Animates the layer's width to the specified value.
    func animateToWidth(_ width: CGFloat,
                        duration: TimeInterval,
                        animationType: CAMediaTimingFunctionName,
                        completion: (() -> Void)?)
}

extension ProgressAnimatable {

    func setToWidth(_ width: CGFloat) {
        guard width >= 0 else { return }
        
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
        guard width >= 0, width != self.bounds.width else {
            completion?()
            return
        }
        
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
