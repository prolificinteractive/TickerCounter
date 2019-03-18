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
    
    // MARK: - Properties
    
    // MARK: - Public API
    
    /// The ending value of the counter
    public var value: Int?
    
    /// The starting "value" of the ticker
    public var placeholderValue: String?
    
    /// Set to true to use the placeholder
    public var placeholderActive = true
    
    /// The alignment of the number within the frame
    public var alignment: NSTextAlignment = .center
    
    /// The color of the ticker text
    public var textColor: UIColor = UIColor.black
    
    /// The font of the ticker text
    public var font: UIFont? = UIFont(name: "HelveticaNeue-Bold", size: 42)
    
    /// The duration of the animation from start to completion
    public var duration: CFTimeInterval = 1
    public var shouldFadeEdges = true
    public var animationDirection: AnimationDirection = .rightToLeft
    public var scrollDirection: ScrollDirection = .topToBottom
    public var calculationMode: UIViewKeyframeAnimationOptions = .calculationModeLinear
    public var type: TickerType = .independent
    public var rotationType: RotationType = .nearest
    public var commaFormatting = true

    // MARK: Private vars
    
    private let base10Numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private var placeholderNumbers: [Int] {
        guard let placeholderValue = placeholderValue else { return [] }
        return placeholderValue.compactMap { Int(String($0)) }
    }
    private var scrollLayers: [UIView] = []
    private var numbersText: [String] = []
    private var scrollLabels: [UILabel] = []
    private var placeholderLabel = UILabel()
    private var gradientLayer = CAGradientLayer()
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // MARK: - Initialization
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        if shouldFadeEdges {
            addGradientMask()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
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
        createBasicAnimation()
    }
    
    // MARK: - Private Methods
    
    private func relativeStartTime(index: Int) -> Double {
        switch type {
        case .cascade:
            return 0
        case .independent:
            let offset = 1 / Double(scrollLayers.count)
            return Double(index) * offset
        case .even:
            return 0
        }

    }
    
    private func relativeDurationFor(index: Int) -> Double {
        switch type {
        case .cascade:
            return 1 / Double(scrollLayers.count - index)
        case .independent:
            return 1 / Double(scrollLayers.count)
        case .even:
            return 1
        }
    }
    
    private func addGradientMask() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.black.cgColor,
                                UIColor.black.cgColor,
                                UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.1, 0.9, 1]
        layer.mask = gradientLayer
    }
    
    private func prepareAnimations() {
        resetLayersAndAnimations()
        createNumbersText()
        createContentViews()
        createSubviewsForScrollLayers()
    }
    
    private func resetLayersAndAnimations() {
        for layer in scrollLayers {
            layer.removeFromSuperview()
        }
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
        placeholderLabel.textAlignment = alignment
    }
    
    private func createBasicAnimation() {
        placeholderLabel.isHidden = true
        let digitViews: [UIView]
        switch animationDirection {
        case .leftToRight:
            digitViews = scrollLayers
        case .rightToLeft:
            digitViews = scrollLayers.reversed()
        }
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: calculationMode,
                                animations: {
                                    for (index, scrollLayer) in digitViews.enumerated() {
                                        guard let lastframe = scrollLayer.subviews.last?.frame else { return }
                                        UIView.addKeyframe(withRelativeStartTime: self.relativeStartTime(index: index),
                                                           relativeDuration: self.relativeDurationFor(index: index),
                                                           animations: {
                                                            scrollLayer.frame.origin.y = -lastframe.origin.y
                                        })
                                    }
        }) { (_) in
            self.placeholderValue = String(self.value ?? 0)
        }
    }
    
    private func createNumbersText() {
        guard let value = value else {
            return
        }
        let formatted = numberFormatter.string(from: NSNumber(value: value))!
        numbersText = formatted.description.compactMap { String($0) }
    }
    
    private func createContentViews() {

        guard let font = font else { return }
        var characterSize = NSString(string: "0").size(withAttributes: [NSAttributedStringKey.font : font])
        let stringWidth = characterSize.width * CGFloat(numbersText.count)
        var xTracker = CGFloat()
        
        // Controls the x position of the frame of the scroll layer based on the alignment
        switch alignment {
        case .left:
            xTracker = 0
        case .right:
            xTracker = bounds.width - stringWidth
        case .center:
            xTracker = bounds.midX - (stringWidth / 2)
        case .justified:
            xTracker = 0
            characterSize.width = bounds.width / CGFloat(numbersText.count)
        default:
            xTracker = 0
        }
        
        for number in numbersText {
            let contentView = UIView()
            let width = number.isDecimalDigit() ?
                characterSize.width :
                NSString(string: number).size(withAttributes: [NSAttributedStringKey.font : font]).width
            contentView.frame = CGRect(x: xTracker, y: 0, width: width, height: frame.height)
            xTracker += width
            scrollLayers.append(contentView)
            addSubview(contentView)
        }
    }
    
    private func createSubviewsForScrollLayers() {
        guard numbersText.count == scrollLayers.count else { return }
        var scrollingNumbersText = [String]()
        for (index, number) in numbersText.enumerated() {
            let scrollLayer = scrollLayers[index]
            var startingNumber = 0
            if index < placeholderNumbers.endIndex {
                startingNumber = placeholderNumbers[index]
            }
            if number.isDecimalDigit() {
                scrollingNumbersText = rotationType == .nearest ?
                    generateDirectNumberSequence(start: startingNumber, end: Int(number)!) :
                    generateFullRotationNumberSequence(start: startingNumber, end: Int(number)!)
            } else {
                scrollingNumbersText = [number]
            }
            var yPosition: CGFloat = 0
            
            for numberText in scrollingNumbersText {
                let numberLabel = createLabel(numberText)
                numberLabel.frame = CGRect(x: 0, y: yPosition, width: scrollLayer.frame.width, height: scrollLayer.frame.height)
                scrollLayer.addSubview(numberLabel)
                scrollLabels.append(numberLabel)
                if scrollDirection == .topToBottom {
                    yPosition -= numberLabel.frame.height
                } else {
                    yPosition = numberLabel.frame.maxY
                }
            }
        }
    }
    
    private func generateFullRotationNumberSequence(start: Int, end: Int) -> [String] {
        guard end <= 9, start <= 9 else { return [] }
        
        var strings = [String]()
        strings += base10Numbers[start ..< base10Numbers.endIndex]
        strings += base10Numbers[0 ..< start]
       
        if start < end {
            strings += base10Numbers[start ... end]
        }
        if end < start {
            strings += base10Numbers[start ..< base10Numbers.endIndex]
            strings += base10Numbers[0 ... end]
        }
        if end == start {
            strings.append(base10Numbers[end])
        }
        return strings
    }
    
    private func generateDirectNumberSequence(start: Int, end: Int) -> [String] {
        guard end <= 9, start <= 9 else { return [] }
        var strings = [String]()
        
        if start < end {
            strings += base10Numbers[start ... end]
        }
        if end < start {
            strings += base10Numbers[start ..< base10Numbers.endIndex]
            strings += base10Numbers[0 ... end]
        }
        if end == start {
            strings.append(base10Numbers[start])
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

