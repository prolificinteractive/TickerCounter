//
//  TickerCounter.swift
//  TickerCounterTests
//
//  Created by Claire Lynch on 2/16/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import UIKit

public enum AnimationTiming: Int {
    case easeIn
    case easeOut
    case easeInEaseOut
    case linear
}

public enum Alignment: Int {
    case left
    case right
    case center
    case fill
}

/// Custom view class which shows an animated counter.
public final class TickerCounter: UIView {
    
    // MARK: - Properties
    
    // MARK: - Public API
    
    /// The ending value of the counter
    public var value: Int? {
        didSet {
            guard let value = value else { return }
            placeholderValue = String(value)
        }
    }
    
    /// The starting "value" of the ticker
    public var placeholderValue: String?
    
    /// Set to true to use the placeholder
    public var placeholderActive = true
    
    /// The alignment of the number within the frame
    public var alignment: Alignment = .fill
    
    /// The desired animation timing
    public var timing: AnimationTiming = .easeIn
    
    /// The color of the ticker text
    public var textColor: UIColor = UIColor.black
    
    /// The font of the ticker text
    public var font: UIFont? = UIFont(name: "HelveticaNeue-Bold", size: 42)
    
    /// The duration of the animation from start to completion
    public var duration: CFTimeInterval = 1
    
    /// The duration of the offset between the animation of each digit.
    /// Set to 0 for all numbers to animate together
    public var durationOffset: CFTimeInterval = 0.1
    
    /// The amount of numbers that will appear in the animation
    /// of each digit between the start and the end
    public var density: Int = 10
    
    
    /// If the ticker is counting up
    public var isAscending: Bool = true
    
    // MARK: Private vars
    private let base10Numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private var scrollLayers: [CAScrollLayer] = []
    private var numbersText: [String] = []
    private var scrollLabels: [UILabel] = []
    private var placeholderLabel = UILabel()
    private var animationType: String {
        switch timing {
        case .easeIn:
            return kCAMediaTimingFunctionEaseIn
        case .easeOut:
            return kCAMediaTimingFunctionEaseOut
        case .easeInEaseOut:
            return kCAMediaTimingFunctionEaseInEaseOut
        case .linear:
            return kCAMediaTimingFunctionLinear
        }
    }
    
    // MARK: - Initialization
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Public Methods
    
    /// Sets the placeholder number or text that will appear before the animation of the ticker
    ///
    /// - Parameter text: The string you would like to use as a placeholder e.g. "OOO"
    public func setPlaceholder(text: String?) {
        guard let _ = text else {
            placeholderValue = nil
            placeholderLabel = UILabel()
            return
        }
        placeholderValue = text
        createPlaceholder()
    }
    
    public func startAnimation() {
        prepareAnimations()
        createAnimations()
    }
    
    public func stopAnimation() {
        for scrollLayer in scrollLayers {
            scrollLayer.removeAnimation(forKey: "AnimatedCounterViewAnimation")
        }
    }
    
    // MARK: - Private Methods
    
    private func prepareAnimations() {
        resetLayersAndAnimations()
        createNumbersText()
        createScrollLayers()
        createSubviewsForScrollLayers()
    }
    
    private func resetLayersAndAnimations() {
        for layer in scrollLayers {
            layer.removeFromSuperlayer()
        }
        placeholderLabel.isHidden = true
        numbersText.removeAll()
        scrollLayers.removeAll()
        scrollLabels.removeAll()
    }
    
    private func createPlaceholder() {
        guard let placeholderValue = placeholderValue else { return }
        placeholderLabel = createLabel(placeholderValue)
        addSubview(placeholderLabel)
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        let textAlignment: NSTextAlignment
        switch alignment {
        case .left:
            textAlignment = .left
        case .right:
            textAlignment = .right
        case .center:
            textAlignment = .center
        case .fill:
            textAlignment = .justified
        }
        placeholderLabel.textAlignment = textAlignment
    }
    
    private func createAnimations() {
        placeholderLabel.isHidden = true
        for scrollLayer in scrollLayers {
            addBasicAnimation(layer: scrollLayer, isFromTop: true)
        }
    }
    
    private func createNumbersText() {
        guard let value = value else {
            return
        }
        numbersText = value.description.compactMap { String($0) }
    }
    
    private func addBasicAnimation(layer: CAScrollLayer, isFromTop: Bool) {
        guard let lastSublayerFame = layer.sublayers?.last?.frame else { return }
        let animation = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
            animation.fromValue = 0
            animation.toValue = -lastSublayerFame.origin.y
            animation.timingFunction = CAMediaTimingFunction(name: animationType)
            animation.duration = 3
            animation.beginTime = CACurrentMediaTime()
            animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "AnimatedCounterViewAnimation")
    }
    
    private func createScrollLayers() {

        guard let font = font else { return }
        var characterSize = NSString(string: "0").size(withAttributes: [NSAttributedStringKey.font : font])
        let stringWidth = characterSize.width * CGFloat(numbersText.count)
        var xTracker = CGFloat()
        
        // Controls the x position of the frame of the scroll layer based on the alignment
        switch alignment {
        // The X position starts at 0 within the label
        case .left:
            xTracker = 0
        case .right:
            // The x position is the far right of the label minus the width of the string
            xTracker = bounds.width - stringWidth
        case .center:
            // The x position is the middle of the label minus half the width of the string (so that
            // the center of the string is in the bounds of the label
            xTracker = bounds.midX - (stringWidth / 2)
        case .fill:
            // Starts at 0 and then the width of each scroll label is the width of the label divided by the
            // number of characters
            xTracker = 0
            characterSize.width = bounds.width / CGFloat(numbersText.count)
        }
        
        for _ in 0..<numbersText.count {
            let scrollLayer = CAScrollLayer()
            scrollLayer.frame = CGRect(x: xTracker, y: 0, width: characterSize.width, height: characterSize.height)
            xTracker += characterSize.width
            scrollLayers.append(scrollLayer)
            layer.addSublayer(scrollLayer)
        }
    }
    
    private func createSubviewsForScrollLayers() {
        guard numbersText.count == scrollLayers.count else { return }
        for (index, number) in numbersText.enumerated() {
            let scrollLayer = scrollLayers[index]
            let scrollingNumbersText = numberStringGenerator(number: number)
            var yPosition: CGFloat = 0
            
            // Creates one label for each number
            for numberText in scrollingNumbersText {
                let numberLabel = createLabel(numberText)
                numberLabel.frame = CGRect(x: 0, y: yPosition, width: scrollLayer.frame.width, height: scrollLayer.frame.height)
                scrollLayer.addSublayer(numberLabel.layer)
                scrollLabels.append(numberLabel) // need to put in a var to keep in memory for some reason
                yPosition = numberLabel.frame.maxY
            }
        }
        
    }
    
    private func numberStringGenerator(number: String) -> [String] {
        guard let intNumber = Int(number) else { return [] }
        var strings = [String]()
        for i in 0...intNumber {
            strings.append(base10Numbers[i])
        }
        return strings
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

