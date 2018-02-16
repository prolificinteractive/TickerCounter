//
//  TickerCounterTests.swift
//  TickerCounterTests
//
//  Created by Harlan Kellaway on 2/16/18.
//  Copyright © 2018 Prolific Interactive. All rights reserved.
//

import XCTest
@testable import TickerCounter

class TickerCounterTests: XCTestCase {
    
    var tickerCounter: TickerCounter!
    
    override func setUp() {
        super.setUp()
        
        tickerCounter = TickerCounter()
    }
    
    override func tearDown() {
        tickerCounter = nil
        
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertNotNil(tickerCounter)
    }
    
}
