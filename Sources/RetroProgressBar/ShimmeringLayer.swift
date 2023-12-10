//
//  ShimmeringLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/8/23.
//

import UIKit

final class ShimmeringLayer: CAGradientLayer, ProgressAnimatable {

    let glowColor: UIColor = UIColor.white
    
    private func shimmerAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func opacityAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 0.1 // Quick transition to transparent
        animation.beginTime = shimmerAnimation().duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    private func animationGroup() -> CAAnimationGroup {
        let pauseDuration = 3.0 // Duration of pause between shimmering
        let shimmerAnimation = shimmerAnimation()
        let opacityAnimation = opacityAnimation()
        let animationGroup = CAAnimationGroup()
        
        animationGroup.animations = [shimmerAnimation, opacityAnimation]
        animationGroup.duration = shimmerAnimation.duration + pauseDuration
        animationGroup.repeatCount = Float.infinity
        
        return animationGroup
    }

    override init() {
        super.init()

        setupLayer()
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()

        startAnimation()
    }
    
    private func setupLayer() {
        let lightColor = UIColor.white.withAlphaComponent(0.7).cgColor
        let darkColor = UIColor.white.withAlphaComponent(0).cgColor
        
        colors = [
            darkColor,
            lightColor,
            darkColor
        ]
        
        anchorPoint = CGPoint(x: 0, y: 0.5)
        locations = [0.0, 0.5, 1.0]
        startPoint = CGPoint(x: 0.0, y: 0.5)
        endPoint = CGPoint(x: 1.0, y: 0.5)

        shadowColor = glowColor.cgColor
        shadowRadius = 5.0
        shadowOpacity = 1
        shadowOffset = .zero
    }
    
    private func startAnimation() {
        if animation(forKey: "shimmerEffect") == nil {
            let animationGroup = animationGroup()
            add(animationGroup, forKey: "shimmerEffect")
        }
    }
}
