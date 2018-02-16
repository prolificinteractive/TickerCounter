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
        
        tickerCounter = TickerCounter(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

}

