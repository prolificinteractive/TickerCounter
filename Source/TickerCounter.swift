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
    public var value: Double?
    
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
    
    /// Controls whether the edges of the view fade to transparent
    public var shouldFadeEdges = true
    
    /// Controls the horizontal direction of the animation
    public var animationDirection: AnimationDirection = .rightToLeft
    
    /// Controls the vertical direction of the animation
    public var scrollDirection: ScrollDirection = .topToBottom
    
    /// Controls the type of the ticker counter
    public var type: TickerType = .cascade {
        didSet {
            print(type)
        }
    }
    
    /// The type of number for display in the TickerCounter
    public var numberFormat: NumberFormat = .currency
    
    // MARK: Private vars
    
    private var placeholderArray: [String] {
        return placeholderValue?.compactMap { String($0) } ?? []
    }
    private var contentViews = [UIView]()
    private var valueString: String {
        guard let value = value else { return "" }
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    private var valueArray = [String]()
    private var scrollLabels = [UILabel]()
    private var placeholderLabel = UILabel()
    private var gradientLayer = CAGradientLayer()
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        switch numberFormat {
        case .currency:
            formatter.numberStyle = .currency
        case .decimal:
            formatter.numberStyle = .decimal
        case .none:
            formatter.numberStyle = .none
        }
        return formatter
    }()
    
    // MARK: - Lifecycle
    
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
        createAnimations()
    }
    
    // MARK: - Private Methods
    
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
        createValueArray()
        createContentViews()
        createSubviewsForScrollLayers()
    }
    
    private func resetLayersAndAnimations() {
        contentViews.forEach { $0.removeFromSuperview() }
        valueArray.removeAll()
        contentViews.removeAll()
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
    
    private func createAnimations() {
        placeholderLabel.isHidden = true
        let digitViews: [UIView]
        switch animationDirection {
        case .leftToRight:
            digitViews = contentViews
        case .rightToLeft:
            digitViews = contentViews.reversed()
        }
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: type.calculationMode(),
                                animations: {
                                    for (index, scrollLayer) in digitViews.enumerated() {
                                        guard let lastframe = scrollLayer.subviews.last?.frame else { return }
                                        UIView.addKeyframe(withRelativeStartTime: self.type.relativeStartTime(index: index,
                                                                                                              count: self.contentViews.count),
                                                           relativeDuration: self.type.relativeDurationFor(index: index,
                                                                                                           count: self.contentViews.count),
                                                           animations: {
                                                            scrollLayer.frame.origin.y = -lastframe.origin.y
                                        })
                                    }
        }) { (_) in
            self.placeholderValue = self.numberFormatter.string(from: NSNumber(value: self.value ?? 0))
        }
    }
    
    private func createValueArray() {
        guard let value = value ,
            let formatted = numberFormatter.string(from: NSNumber(value: value))
            else {
                return
        }
        valueArray = formatted.compactMap { String($0) }
    }
    
    private func createContentViews() {
        guard let font = font else { return }
        var characterSize = NSString(string: "0").size(withAttributes: [NSAttributedStringKey.font : font])
        let stringWidth = valueString.monospacedStringWidth(attributes: [.font: font])
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
            characterSize.width = bounds.width / CGFloat(valueArray.count)
        default:
            xTracker = 0
        }
        
        for valueString in valueArray {
            let contentView = UIView()
            let width = valueString.isDecimalDigit() ?
                characterSize.width :
                NSString(string: valueString).size(withAttributes: [.font : font]).width
            contentView.frame = CGRect(x: xTracker, y: 0, width: width, height: frame.height)
            xTracker += width
            contentViews.append(contentView)
            addSubview(contentView)
        }
    }
    
    private func createSubviewsForScrollLayers() {
        guard valueArray.count == contentViews.count else { return }
        var scrollingNumbersText = [String]()
        for (index, number) in valueArray.enumerated() {
            let scrollLayer = contentViews[index]
            var startingValue = String()
            var yPosition: CGFloat = 0
            
            if index < placeholderArray.endIndex {
                startingValue = placeholderArray[index]
            }
            
            if number.isDecimalDigit() && startingValue.isDecimalDigit() {
                guard
                    let destinationNumber = Int(number),
                    let startingNumber = Int(startingValue) else { return }
                scrollingNumbersText = startingNumber.ascendingDecimalSequenceTo(destinationNumber).stringArray()
            } else {
                scrollingNumbersText = [number]
            }
            
            for numberText in scrollingNumbersText {
                let numberLabel = createLabel(numberText)
                numberLabel.frame = CGRect(x: 0,
                                           y: yPosition,
                                           width: scrollLayer.frame.width,
                                           height: scrollLayer.frame.height)
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
    
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        label.textAlignment = .center
        label.text = text
        return label
    }
    
}

