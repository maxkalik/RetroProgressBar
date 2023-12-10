//
//  BorderGradientLayer.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/10/23.
//

import UIKit

final class BorderGradientLayer: CAGradientLayer {
    
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()

        layer.strokeColor = UIColor.black.cgColor // Temporary color
        layer.fillColor = nil
        return layer
    }()
    
    init(borderWidth: CGFloat, colors: [UIColor]) {
        super.init()

        self.mask = shapeLayer
        self.colors = colors.map { $0.cgColor }
        self.setBorderWidth(borderWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius - 0.1).cgPath
    }
    
    func setBorderWidth(_ borderWidth: CGFloat) {
        self.shapeLayer.lineWidth = borderWidth
    }
}

