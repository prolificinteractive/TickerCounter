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
    
    func testDirectDecimalSequenceAscending() {
        let start = 0
        let end = 9
        XCTAssertEqual(start.directDecimalSequenceTo(end), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    }
    
    func testDirectDecimalSequenceDescending() {
        let start = 9
        let end = 0
        XCTAssertEqual(start.directDecimalSequenceTo(end), [9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
    }
    
    func testDirectDecimalSequenceAscendingPartial() {
        let start = 2
        let end = 7
        XCTAssertEqual(start.directDecimalSequenceTo(end), [2, 3, 4, 5, 6, 7])
    }
    
    func testDirectDecimalSequenceDescendingPartial() {
        let start = 7
        let end = 2
        XCTAssertEqual(start.directDecimalSequenceTo(end), [7, 6, 5, 4, 3, 2])
    }
    
    func testDirectDecimalSequenceAscendingWrap() {
        let start = 9
        let end = 9
        XCTAssertEqual(start.directDecimalSequenceTo(end), [9])
    }
}
