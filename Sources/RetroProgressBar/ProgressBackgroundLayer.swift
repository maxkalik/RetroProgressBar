//
//  ProgressBackgroundLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/8/23.
//

import UIKit

final class ProgressBackgroundLayer: CAGradientLayer {
    
    override init() {
        super.init()

        locations = [0, 0.5, 1]
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()

        colors = [
            backgroundColor?.lightened(by: 0.3),
            backgroundColor,
            backgroundColor?.darkened(by: 0.5)
        ].compactMap({ $0 })
    }
}
