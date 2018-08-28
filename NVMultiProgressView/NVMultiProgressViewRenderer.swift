//
//  NVMultiProgressViewRenderer.swift
//  NVMultiProgressView
//
//  Created by Nathan Vogel +41786097927 on 28.08.18.
//  Copyright © 2018 Blended Study. All rights reserved.
//

import Foundation

class NVMultiProgressViewRenderer {
    
    private var bars:[Bar] = []
    
    var barCount:Int {
        get {
            return bars.count
        }
    }
    
    func addBar(color: CGColor, parentBounds: CGRect, mainLayer:CALayer) {
        // Add a new bar with a default progress of zero
        let newBar = Bar(color:color, parentBounds:parentBounds)
        bars.append(newBar)
        mainLayer.addSublayer(newBar.layer)
    }
    
    // value should be between 0.0 and 1.0
    func setBarWidth(_ width: CGFloat, forIndex:Int, animated:Bool = false) {
        bars[forIndex].width = width
        bars[forIndex].update(animated:animated)
    }
    
    func setBarColor(_ color:CGColor, forIndex:Int) {
        bars[forIndex].color = color
    }
    
    func updateBounds(_ bounds: CGRect) {
        for bar in bars {
            bar.parentBounds = bounds
            bar.update()
        }
    }
}

private class Bar {
    
    let layer = CALayer()
    
    var width:CGFloat = 0
    
    var parentBounds:CGRect
    
    var color:CGColor = UIColor.blue.cgColor {
        didSet {
            layer.backgroundColor = color
        }
    }
    
    init(color:CGColor, parentBounds:CGRect) {
        self.color = color
        self.parentBounds = parentBounds
        layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        // We need to give the layer an initial bounds to later set bounds.size.width directly.
        layer.bounds = parentBounds
        layer.bounds.size.width = 0
    }
    
    func update(animated:Bool = false) {
        // Save the previous value to animate from it.
        let previousWidth = self.layer.bounds.size.width
        // Actually set and keep the value, regardless of whether it's animated
        self.layer.bounds.size.width = self.width
        
        // Display an animation if needed
        if animated && previousWidth != self.width {
            let layerAnimation = CABasicAnimation(keyPath: "bounds.size.width")
            layerAnimation.duration = 0.36
            layerAnimation.fromValue = previousWidth
            layerAnimation.toValue = self.width
            layer.add(layerAnimation, forKey: "anim")
        }
        
        // Place it where it was before
        layer.position = CGPoint(x: parentBounds.minX, y: parentBounds.midY)
    }
}
