//
//  ProgressMaskLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/8/23.
//

import UIKit

final class ProgressMaskLayer: CAShapeLayer, ProgressAnimatable {

    override init() {
        super.init()
        
        backgroundColor = UIColor.black.cgColor
        anchorPoint = CGPoint(x: 0, y: 0.5)
    }
    
    // Layer Copying for Animations: In Core Animation,
    // when an animation is applied to a layer, the system creates a copy of the layer
    // to represent its state for the duration of the animation.
    // This is known as the layer's "presentation layer."
    // The init(layer: Any) initializer is called to create this copy.
    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
