//
//  BackgroundLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/10/23.
//

import UIKit

final class BackgroundLayer: CALayer {
    
    private let borderGradientLayer: BorderGradientLayer
    private let innerShadowLayer = InnerShadowLayer()

    init(borderWidth: CGFloat, colors: [UIColor]) {
        self.borderGradientLayer = .init(
            borderWidth: borderWidth,
            colors: colors
        )
        super.init()

        insertSublayer(innerShadowLayer, at: 0)
        addSublayer(borderGradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        borderGradientLayer.frame = bounds
        borderGradientLayer.cornerRadius = cornerRadius
        innerShadowLayer.frame = bounds
        innerShadowLayer.cornerRadius = cornerRadius
    }
    
    func setBorderWidth(_ borderWidth: CGFloat) {
        borderGradientLayer.setBorderWidth(borderWidth)
    }
    
    func setBorderColors(_ colors: [UIColor]) {
        borderGradientLayer.colors = colors
    }
}
