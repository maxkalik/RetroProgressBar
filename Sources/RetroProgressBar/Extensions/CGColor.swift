//
//  File.swift
//  
//
//  Created by Maksim Kalik on 12/10/23.
//

import CoreGraphics

extension CGColor {
    func darkened(by value: CGFloat) -> CGColor {
        guard let colorSpace = self.colorSpace,
              let components = self.components,
              colorSpace.model == .rgb,
              components.count >= 3 else {
            return self
        }

        /*
         After ensuring that the percentage is within the range of 0 to 1, 1 - percentage is used to calculate the factor by which to multiply the color components. For instance, if you want to darken a color by 20% (or 0.2), then the adjustment factor would be 1 - 0.2, which equals 0.8. This means each color component will be multiplied by 0.8, effectively reducing its intensity and darkening the color.
         
         */
        let multiplier = 1 - min(max(value, 0), 1)
        let red = components[0] * multiplier
        let green = components[1] * multiplier
        let blue = components[2] * multiplier
        let alpha = components.count > 3 ? components[3] : 1.0

        return CGColor(
            colorSpace: colorSpace,
            components: [red, green, blue, alpha]
        ) ?? self
    }
    
    func lightened(by value: CGFloat) -> CGColor {
        guard let colorSpace = self.colorSpace,
              let components = self.components,
              colorSpace.model == .rgb,
              components.count >= 3 else {
            return self
        }
        
        // Calculate the new components
        let red = min(components[0] + value, 1.0)
        let green = min(components[1] + value, 1.0)
        let blue = min(components[2] + value, 1.0)
        let alpha = components.count > 3 ? components[3] : 1.0
        
        return CGColor(
            colorSpace: colorSpace,
            components: [red, green, blue, alpha]
        ) ?? self
    }
}
