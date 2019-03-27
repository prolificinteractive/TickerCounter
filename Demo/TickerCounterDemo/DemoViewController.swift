//
//  DemoViewController.swift
//  TickerCounterDemo
//
//  Created by Kevin Miller  on 3/15/19.
//  Copyright © 2019 Prolific Interactive. All rights reserved.
//

import UIKit
import TickerCounter

class DemoViewController: UIViewController {

    @IBOutlet private weak var totalSavedCounter: TickerCounter!
    @IBOutlet weak var longCounter: TickerCounter!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var creditCounter: TickerCounter!
    @IBOutlet private weak var likesCounter: TickerCounter!
    
    private var gradientLayer = CAGradientLayer()
    private var likeCount: Double {
        return Double(Int.random(in: 10000...99999))
    }
    private var totalSavedAmount = 41085.15
    private var creditAmount: Double = 87234
    private var longNumber: Double {
        return Double(UInt64.random(in: 100000000000...999999999999))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupTotalSavedCounter()
        setupCreditCounter()
        setupLikeCounter()
        setupLongCounter()
        setupTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totalSavedCounter.startAnimation()
        creditCounter.startAnimation()
        longCounter.startAnimation()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 0.18, green: 0.19, blue: 0.57, alpha:1.0).cgColor,
            UIColor(red: 0, green: 0, blue: 1.00, alpha:1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = gradientView.bounds
        gradientView.layer.addSublayer(gradientLayer)
    }
    private func setupTotalSavedCounter() {
        totalSavedCounter.font = UIFont.systemFont(ofSize: 50)
        totalSavedCounter.textColor = .white
        totalSavedCounter.alignment = .center
        totalSavedCounter.placeholderValue = "$00,000.00"
        totalSavedCounter.value = totalSavedAmount
        totalSavedCounter.animationDirection = .rightToLeft
        totalSavedCounter.scrollDirection = .topToBottom
        totalSavedCounter.type = .even
        totalSavedCounter.duration = 1.0
    }
    
    private func setupCreditCounter() {
        creditCounter.font = UIFont.systemFont(ofSize: 30)
        creditCounter.textColor = .blue
        creditCounter.alignment = .center
        creditCounter.numberType = .decimal
        creditCounter.placeholderValue = "00,000"
        creditCounter.value = creditAmount
        creditCounter.animationDirection = .rightToLeft
        creditCounter.scrollDirection = .bottomToTop
        creditCounter.type = .even
        creditCounter.duration = 1
    }
    
    private func setupLikeCounter() {
        likesCounter.font = UIFont.systemFont(ofSize: 30)
        likesCounter.textColor = .blue
        likesCounter.alignment = .center
        likesCounter.numberType = .decimal
        likesCounter.placeholderValue = "00,000"
        likesCounter.value = creditAmount
        likesCounter.animationDirection = .leftToRight
        likesCounter.scrollDirection = .bottomToTop
        likesCounter.type = .even
        likesCounter.duration = 1
    }
    
    private func setupLongCounter() {
        longCounter.font = UIFont.systemFont(ofSize: 30)
        longCounter.textColor = .blue
        longCounter.alignment = .center
        longCounter.numberType = .decimal
        longCounter.value = longNumber
        longCounter.animationDirection = .leftToRight
        longCounter.scrollDirection = .bottomToTop
        longCounter.type = .independent
        longCounter.duration = 2
    }
    
    private func setupTimer() {
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            self.updateCounters()
        }
    }
    
    private func updateCounters() {
        totalSavedAmount += Double.random(in: 0...0.99)
        totalSavedCounter.value = totalSavedAmount
        totalSavedCounter.startAnimation()
        creditAmount += 1
        creditCounter.duration = 2
        creditCounter.animationDirection = .rightToLeft
        creditCounter.value = creditAmount
        creditCounter.startAnimation()
        likesCounter.value = likeCount
        likesCounter.startAnimation()
        longCounter.value = longNumber
        longCounter.startAnimation()
    }

}
