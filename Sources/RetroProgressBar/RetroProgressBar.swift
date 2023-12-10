//  Created by Maksim Kalik on 3/19/23.

import UIKit

fileprivate let WIDTH_ANIMATABLE_INSET: CGFloat = 3

public final class RetroProgressBar: UIView {
    
    /// The color of the progress bar
    public var progressColor: UIColor = UIColor.systemBlue {
        didSet {
            setProgressColor(progressColor)
        }
    }
    
    /// Corner radius of the progress bar view
    public var cornerRadius: CGFloat = 0 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
    
    /// Border width of the progress bar
    public var borderWidth: CGFloat = 1 {
        didSet {
            setBorderWidth(borderWidth)
        }
    }
    
    /// Border gradient colors array
    public var borderColors: [UIColor] = [UIColor.gray, UIColor.white] {
        didSet {
            setBorderColors(borderColors)
        }
    }

    private lazy var backgroundLayer = BackgroundLayer(
        borderWidth: borderWidth,
        colors: borderColors
    )
    
    private let glareLayer = ProgressGlareLayer()
    private let shimmeringLayer = ShimmeringLayer()
    private var animatedLayers: [ProgressAnimatable] = []
    private let progressMaskLayer = ProgressMaskLayer()
    private let progressBackgroundLayer = ProgressBackgroundLayer()
    
    public init() {
        super.init(frame: .zero)
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = true
        
        layer.addSublayer(progressMaskLayer)
        layer.addSublayer(progressBackgroundLayer)
        layer.insertSublayer(backgroundLayer, at: 0)
        
        
        progressBackgroundLayer.addSublayer(shimmeringLayer)
        progressBackgroundLayer.addSublayer(glareLayer)
        
        progressBackgroundLayer.mask = progressMaskLayer
        
        setProgressColor(progressColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        layoutMaksedLayer(shimmeringLayer)
        layoutMaksedLayer(glareLayer)
        
        progressMaskLayer.frame.size.height = bounds.height - borderWidth
        progressMaskLayer.position = .init(x: borderWidth / 2, y: bounds.height / 2)

        progressBackgroundLayer.frame = bounds
        backgroundLayer.frame = bounds
    }
    
    private func layoutMaksedLayer(_ layer: CALayer) {
        layer.frame.size.height = bounds.height / 2
        layer.position = .init(
            x: (WIDTH_ANIMATABLE_INSET + borderWidth) / 2,
            y: bounds.height / 4
        )
    }

    /// Set value without animation
    public func setValue(_ value: Double) {
        let newWidth = bounds.width * value
        shimmeringLayer.setToWidth(newWidth)
        progressMaskLayer.setToWidth(newWidth)
    }
    
    /// Set value with animation
    public func setValueWithAnimation(_ value: Double,
                               duration: TimeInterval = 1.0,
                               animationType: CAMediaTimingFunctionName = .easeInEaseOut,
                               completion: (() -> Void)? = nil) {
        
        let normalizedValue = max(min(value, 1), 0)
        let newWidth = bounds.width * normalizedValue - borderWidth
        let animationGroup = DispatchGroup()

        animationGroup.enter()
        shimmeringLayer.animateToWidth(
            newWidth - WIDTH_ANIMATABLE_INSET,
            duration: duration,
            animationType: animationType,
            completion: animationGroup.leave
        )
        
        animationGroup.enter()
        progressMaskLayer.animateToWidth(
            newWidth,
            duration: duration,
            animationType: animationType,
            completion: animationGroup.leave
        )
        
        animationGroup.enter()
        glareLayer.animateToWidth(
            newWidth - WIDTH_ANIMATABLE_INSET,
            duration: duration,
            animationType: animationType,
            completion: animationGroup.leave
        )

        animationGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            completion?()
        }
    }
    
    /// Set corner radius of the progress bar
    public func setCornerRadius(_ cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        progressMaskLayer.cornerRadius = cornerRadius - borderWidth / 2
        shimmeringLayer.cornerRadius = cornerRadius / 2
        glareLayer.cornerRadius = cornerRadius / 2
        backgroundLayer.cornerRadius = cornerRadius
    }
    
    /// Set progress bar color
    public func setProgressColor(_ color: UIColor) {
        progressBackgroundLayer.backgroundColor = color.cgColor
    }
    
    /// Set border width of the progress bar
    public func setBorderWidth(_ borderWidth: CGFloat) {
        setCornerRadius(cornerRadius)
        backgroundLayer.setBorderWidth(borderWidth)
    }
    
    /// Set border gradient colors
    public func setBorderColors(_ colors: [UIColor]) {
        backgroundLayer.setBorderColors(colors)
    }
}
