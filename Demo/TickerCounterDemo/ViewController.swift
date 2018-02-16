//
//  ViewController.swift
//  TickerCounterDemo
//
//  Created by Harlan Kellaway on 2/16/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import TickerCounter
import UIKit

class ViewController: UIViewController {
    
    var tickerCounter: TickerCounter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tickerCounter = TickerCounter(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 65))
        tickerCounter.value = 270577
        self.tickerCounter = tickerCounter
        
        view.addSubview(tickerCounter)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tickerCounter?.startAnimation()
    }

}

