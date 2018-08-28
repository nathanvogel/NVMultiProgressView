//
//  NVMultiProgressView.swift
//  
//
//  Created by Nathan Vogel +41786097927 on 27.08.18.
//

import UIKit


@IBDesignable
public class NVMultiProgressView: UIView {

    public var minimumValue: Double = 0
    public var maximumValue: Double = 1
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    private var renderer = NVMultiProgressViewRenderer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        bounds = frame
        layer.masksToBounds = true
        // didSet isn't called on init()
        layer.cornerRadius = self.cornerRadius
    }
    
    private func createBarsForIndex(_ index:Int) {
        // Add transparent bars until we have a big enough array
        while (renderer.barCount <= index) {
            renderer.addBar(color: UIColor.clear.cgColor, parentBounds: bounds, mainLayer: layer)
        }
    }
    
    public func setProgress(_ value: Double, forIndex: Int, animated:Bool = false) {
        // Make sure there're enough bars
        createBarsForIndex(forIndex)
        // Constrain the given value
        let newValue = min(maximumValue, max(minimumValue, value))
        // Render the new width
        renderer.setBarWidth(CGFloat(newValue) * bounds.width, forIndex: forIndex, animated: animated)
    }
    
    public func setColor(_ color: UIColor, forIndex: Int, animated:Bool = false) {
        // Make sure there're enough bars
        createBarsForIndex(forIndex)
        renderer.setBarColor(color.cgColor, forIndex: forIndex)
    }
    
}


extension NVMultiProgressView {
    
    static let colorGreenHeavy = UIColor(red:0.52, green:0.95, blue:0.52, alpha:1.0)
    static let colorGreen = UIColor(red:0.79, green:1.00, blue:0.80, alpha:1.0)
    static let colorRed = UIColor(red:1.00, green:0.80, blue:0.79, alpha:1.0)
    static let colorRedHeavy = UIColor(red:0.94, green:0.53, blue:0.52, alpha:1.0)
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setProgress(0.7, forIndex: 0)
        setColor(NVMultiProgressView.colorRed, forIndex: 0)
        setProgress(0.3, forIndex: 1)
        setColor(NVMultiProgressView.colorGreen, forIndex: 1)
//        renderer.updateBounds(bounds)
    }
}



