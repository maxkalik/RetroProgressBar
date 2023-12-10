//
//  ProgressGlareLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/9/23.
//

import UIKit

final class ProgressGlareLayer: CALayer, ProgressAnimatable {
    
    override init() {
        super.init()

        backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor

        anchorPoint = CGPoint(x: 0, y: 0.5)
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
