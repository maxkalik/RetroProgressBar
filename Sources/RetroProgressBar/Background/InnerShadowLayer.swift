//
//  InnerShadowLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/10/23.
//

import UIKit

final class InnerShadowLayer: CAShapeLayer {

    override init() {
        super.init()
        
        masksToBounds = true
        shadowRadius = 3
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowOpacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        let shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: -5, dy: -5), cornerRadius: cornerRadius)
        let cutoutPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()

        shadowPath.append(cutoutPath)

        self.shadowPath = shadowPath.cgPath
    }
}
