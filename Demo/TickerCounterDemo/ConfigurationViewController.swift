//
//  ConfigurationViewController.swift
//  TickerCounterDemo
//
//  Created by Kevin Miller on 3/14/19.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import UIKit
import TickerCounter

class ConfigurationViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: IBOutlets
    
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var tickerCounter: TickerCounter!
    
    //MARK: Private Vars
    
    private var randomValue: Double {
        let random = Double.random(in: 100000...999999)
        lastValue = random
        return random
    }
    private var lastValue: Double = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTickerCounter()
    }
    
    //MARK: - IBActions
    
    @IBAction private func durationValueChanged(_ sender: UISlider) {
        tickerCounter.duration = Double(sender.value)
        durationLabel.text = "Duration \(sender.value.truncatingRemainder(dividingBy: 10))"
    }
    
    @IBAction private func scrollDirectionValueChanged(_ sender: UISegmentedControl) {
        guard let selection = ScrollDirection(rawValue: sender.selectedSegmentIndex) else { return }
        tickerCounter.scrollDirection = selection
        
    }
    
    @IBAction private func horizontalDirectionValueChanged(_ sender: UISegmentedControl) {
        guard let selection = AnimationDirection(rawValue: sender.selectedSegmentIndex) else { return }
        tickerCounter.animationDirection = selection
    }
    
    @IBAction private func tickerTypeValueChanged(_ sender: UISegmentedControl) {
        guard let selection = TickerType(rawValue: sender.selectedSegmentIndex) else { return }
        tickerCounter.type = selection
    }
    
    @IBAction private func calculationSegmentDidTouch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tickerCounter.calculationMode = .calculationModeLinear
        case 1:
            tickerCounter.calculationMode = .calculationModeCubic
        case 2:
            tickerCounter.calculationMode = .calculationModeCubicPaced
        case 3:
            tickerCounter.calculationMode = .calculationModeDiscrete
        case 4:
            tickerCounter.calculationMode = .calculationModePaced
        default:
            return
        }
    }
    
    @IBAction private func alignmentControlDidTouch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tickerCounter.alignment = .left
        case 1:
            tickerCounter.alignment = .right
        case 2:
            tickerCounter.alignment = .center
        case 3:
            tickerCounter.alignment = .justified
        default:
            return
        }
        tickerCounter.alignment = .center
    }
    
    @IBAction private func shuffleDidTouchUpInside(_ sender: Any) {
        shuffleValue()
    }
    
    
    //MARK: - Private funcs
    private func shuffleValue() {
        tickerCounter.value = randomValue
        tickerCounter.startAnimation()
    }
    
    private func configureTickerCounter() {
        tickerCounter.textColor = .black
        tickerCounter.font = UIFont.boldSystemFont(ofSize: 75)
        tickerCounter.alignment = .center
        tickerCounter.duration = 0.75
        tickerCounter.setPlaceholder(text: "000,000")
    }
    
}
