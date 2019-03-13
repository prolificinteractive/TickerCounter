//
//  ViewController.swift
//  TickerCounterDemo
//
//  Created by Harlan Kellaway on 2/16/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import UIKit
import TickerCounter

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: IBOutlets
    
    @IBOutlet private weak var densityLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var tickerCounter: TickerCounter!
    
    //MARK: Private Vars
    
    private var randomValue: Int {
        return Int.random(in: 100000...999999)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTickerCounter()
    }
    
    //MARK: - IBActions
    
    @IBAction private func acsendingDidTouch(_ sender: UISwitch) {
        tickerCounter.isAscending = sender.isOn
    }
    
    @IBAction private func densityDidTouch(_ sender: UISlider) {
        let value = Int(sender.value)
        tickerCounter.density = value
        densityLabel.text = "Density: \(value)"
    }
    
    @IBAction private func durationDidTouch(_ sender: UISlider) {
        tickerCounter.duration = Double(sender.value)
        durationLabel.text = "Duration: \(sender.value)"
    }
    
    @IBAction private func timingSegmentDidTouch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tickerCounter.animationTiming = .curveEaseIn
        case 1:
            tickerCounter.animationTiming = .curveEaseOut
        case 2:
            tickerCounter.animationTiming = .curveEaseInOut
        case 3:
            tickerCounter.animationTiming = .curveLinear
        default:
            return
        }
    }
    
    @IBAction private func alignmentControlDidTouch(_ sender: UISegmentedControl) {
        // TODO: Update this to use segment control
        tickerCounter.alignment = .center
    }
    
    @IBAction private func animateDidTouch(_ sender: Any) {
        demoAnimation()
    }
    
    //MARK: - Private funcs
    private func demoAnimation() {
        tickerCounter.value = randomValue
        tickerCounter.startAnimation()
    }
    
    private func configureTickerCounter() {
        tickerCounter.textColor = .black
        tickerCounter.font = UIFont.boldSystemFont(ofSize: 65)
        tickerCounter.density = 6
        tickerCounter.durationOffset = 0.5
        tickerCounter.alignment = .center
        tickerCounter.duration = 2.0
        tickerCounter.setPlaceholder(text: "000000")
    }
    
}
