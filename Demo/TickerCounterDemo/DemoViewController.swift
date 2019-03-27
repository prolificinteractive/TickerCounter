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
    @IBOutlet private weak var gradientView: UIView!
    
    private var gradientLayer = CAGradientLayer()
    private var likeCount = 23000.00
    private var totalSavedAmount = 41085.15
    private var secondsCount = 259200.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupTotalSavedCounter()
        setupTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totalSavedCounter.startAnimation()
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
        totalSavedCounter.value = totalSavedAmount
        totalSavedCounter.animationDirection = .rightToLeft
        totalSavedCounter.scrollDirection = .topToBottom
        totalSavedCounter.calculationMode = .calculationModeLinear
        totalSavedCounter.type = .cascade
        totalSavedCounter.duration = 1.0
    }
    
    private func setupTimer() {
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            self.updateCounters()
        }
    }
    
    private func updateCounters() {
        totalSavedCounter.calculationMode = .calculationModePaced
        totalSavedAmount += Double.random(in: 0...0.99)
        totalSavedCounter.value = totalSavedAmount
        totalSavedCounter.startAnimation()
    }

}
