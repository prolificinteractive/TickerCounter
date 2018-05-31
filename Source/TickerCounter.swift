//
//  TickerCounter.swift
//  TickerCounterTests
//
//  Created by Claire Lynch on 2/16/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import UIKit

/// Custom view class which shows an animated counter.
public final class TickerCounter: UIView {
    
    // MARK: Dependencies
    
    /// The value for the ticker to display
    public var value: Int?
    
    // MARK: Properties
    
    /// The color of the ticker numbers
    public var textColor: UIColor = UIColor.black
    
    /// The font of the ticker numbers
    public var font: UIFont? = UIFont(name: "HelveticaNeue-Bold", size: 42)
    
    /// The duration of the animation from start to completion
    public var duration: CFTimeInterval = 3
    
    /// The duration of the offset between the animation of each digit.
    /// Set to 0 for all numbers to animate in sync
    public var durationOffset: CFTimeInterval = 0.3
    
    /// The number of numbers that will be scrolled through during the
    /// duration of the animation.
    public var density: Int = 5
    
    /// If the ticker is ascending. Set to false for descending.
    public var isAscending: Bool = false
    
    private var scrollLayers: [CAScrollLayer] = []
    private var numbersText: [String] = []
    private var scrollLabels: [UILabel] = []
    
    // MARK: Initialization
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: Public Methods
    
    /// Start the animation of the ticker
    public func startAnimation() {
        prepareAnimations()
        createAnimations()
    }
    
    /// Stop the animation of the ticker
    public func stopAnimation() {
        for scrollLayer in scrollLayers {
            scrollLayer.removeAnimation(forKey: "AnimatedCounterViewAnimation")
        }
    }
    
    // MARK: Private Methods
    
    private func prepareAnimations() {
        for layer in scrollLayers {
            layer.removeFromSuperlayer()
        }
        
        numbersText.removeAll()
        scrollLayers.removeAll()
        scrollLabels.removeAll()
        
        createNumbersText()
        createScrollLayers()
    }
    
    private func createAnimations() {
        let digitDuration = duration - (Double(numbersText.count) * durationOffset)
        var offset: CFTimeInterval = 0
        
        for scrollLayer in scrollLayers {
            let animation = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
            animation.duration = digitDuration + offset
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            if let maxY = scrollLayer.sublayers?.last?.frame.origin.y {
                animation.fromValue = isAscending ? -maxY : 0
                animation.toValue = isAscending ? 0 : -maxY
            }
            
            scrollLayer.add(animation, forKey: "AnimatedCounterViewAnimation")
            offset += durationOffset
        }
    }
    
    private func createNumbersText() {
        guard let value = value else {
            return
        }
        
        numbersText = value.description.flatMap{ String($0) }
    }
    
    private func createScrollLayers() {
        let width = frame.width / CGFloat(numbersText.count)
        let height = frame.height
        
        for i in 0..<numbersText.count {
            let scrollLayer = CAScrollLayer()
            scrollLayer.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            scrollLayers.append(scrollLayer)
            layer.addSublayer(scrollLayer)
        }
        
        for i in 0..<numbersText.count {
            createContentForLayer(scrollLayers[i], withNumberText: numbersText[i])
        }
    }
    
    private func createContentForLayer(_ layer: CAScrollLayer, withNumberText numberText: String) {
        guard let number = Int(numberText) else {
            return
        }
        
        var scrollingNumbersText = [String]()
        for i in 0...density {
            let scrollNumber = (number + i) % 10
            scrollingNumbersText.append(scrollNumber.description)
        }
        
        scrollingNumbersText.append(numberText)
        
        if isAscending {
            scrollingNumbersText.reverse()
        }
        
        var height: CGFloat = 0
        for numberText in scrollingNumbersText {
            let scrollLabel = createLabel(numberText)
            scrollLabel.frame = CGRect(x: 0, y: height, width: layer.frame.width, height: layer.frame.height)
            layer.addSublayer(scrollLabel.layer)
            scrollLabels.append(scrollLabel)
            height = scrollLabel.frame.maxY
        }
    }
    
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        label.textAlignment = .center
        label.text = text
        return label
    }
    
}
