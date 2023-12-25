//
//  File.swift
//  BackgroundEraser
//
//  Created by Mehedi Hasan on 16/10/22.
//

import Foundation
import UIKit

class CustomSlider: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        super.trackRect(forBounds: bounds)

        var customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 2))
        //print("bounds.size.width  ", bounds.size.width,"   ",  self.frame.midY)
        customBounds.origin.y = min(22, self.frame.midY)
        return customBounds
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        var bounds = self.bounds
        bounds = bounds.insetBy(dx: -50, dy: -50)
        return bounds.contains(point)
    }
}

extension UISlider {
    
    var thumbCenterX: CGFloat {
        var trackRect = self.trackRect(forBounds: frame)
       // trackRect.origin.y = 20
        let thumbRect = self.thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
       // print("MIDDXXX  ", thumbRect," ", trackRect)
        return thumbRect.midX
    }
}
