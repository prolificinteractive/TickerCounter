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

    @IBOutlet private weak var totalRidesCounter: TickerCounter!
    @IBOutlet private weak var secondsCounter: TickerCounter!
    @IBOutlet private weak var likeCounter: TickerCounter!
    
    private var likeCount = 23000
    private var rideCount = 235
    private var secondsCount = 259200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTotalRidesCounter()
        setupSecondsCounter()
        setupLikeCounter()
        setupTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totalRidesCounter.startAnimation()
        secondsCounter.startAnimation()
    }
    
    private func setupTotalRidesCounter() {
        totalRidesCounter.font = UIFont.systemFont(ofSize: 120)
        totalRidesCounter.setPlaceholder(text: "000")
        totalRidesCounter.textColor = .black
        totalRidesCounter.alignment = .center
        totalRidesCounter.value = rideCount
        totalRidesCounter.animationDirection = .rightToLeft
        totalRidesCounter.calculationMode = .calculationModeLinear
        totalRidesCounter.type = .independent
        totalRidesCounter.duration = 1.5
    }
    
    private func setupSecondsCounter() {
        secondsCounter.font = UIFont.systemFont(ofSize: 60)
        secondsCounter.setPlaceholder(text: "000000")
        secondsCounter.textColor = .black
        secondsCounter.alignment = .center
        secondsCounter.value = secondsCount
        secondsCounter.scrollDirection = .bottomToTop
        secondsCounter.animationDirection = .rightToLeft
        secondsCounter.calculationMode = .calculationModeLinear
        secondsCounter.type = .even
        secondsCounter.duration = 1
    }
    
    private func setupLikeCounter() {
        likeCounter.font = UIFont.systemFont(ofSize: 15)
        likeCounter.setPlaceholder(text: "000")
        likeCounter.textColor = .black
        likeCounter.alignment = .center
        likeCounter.value = likeCount
        likeCounter.scrollDirection = .topToBottom
        likeCounter.animationDirection = .rightToLeft
        likeCounter.calculationMode = .calculationModeLinear
        likeCounter.type = .even
        likeCounter.duration = 1
    }
    
    private func setupTimer() {
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            self.updateCounters()
        }
    }
    
    private func updateCounters() {
        likeCount += Int.random(in: 1...10)
        secondsCount -= 1
        likeCounter.value = likeCount
        likeCounter.startAnimation()
        secondsCounter.value = secondsCount
        secondsCounter.startAnimation()
        rideCount = Int.random(in: 100..<1000)
        totalRidesCounter.value = rideCount
        totalRidesCounter.startAnimation()
    }

}
