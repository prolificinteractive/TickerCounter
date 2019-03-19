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
    
    func testAscendingDecimalSequence() {
        let start = 0
        let end = 9
        XCTAssertEqual(start.ascendingDecimalSequenceTo(end), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    }
    
    func testAscendingDecimalSequenceWrap() {
        let start = 7
        let end = 3
        XCTAssertEqual(start.ascendingDecimalSequenceTo(end), [7, 8, 9, 0, 1, 2, 3])
    }
    
    func testAscendingDecimalSequenceEqual() {
        let start = 3
        let end = 3
        XCTAssertEqual(start.ascendingDecimalSequenceTo(end), [3])
    }
    
    func testDescendingDecimalSequence() {
        let start = 9
        let end = 0
        XCTAssertEqual(start.descendingDecimalSequenceTo(end), [9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
    }
    
    func testDescendingDecimalSequenceWrap() {
        let start = 3
        let end = 7
        XCTAssertEqual(start.descendingDecimalSequenceTo(end), [3, 2, 1, 0, 9, 8, 7])
    }
    
    func testDescendingDecimalSequenceEqual() {
        let start = 3
        let end = 3
        XCTAssertEqual(start.descendingDecimalSequenceTo(end), [3])
    }
    
  
}
