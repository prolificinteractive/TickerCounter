//
//  Int+DecimalSequence.swift
//  Ticker Counter
//
//  Created by Kevin Miller  on 3/14/19.
//  Copyright © 2019 Prolific Interactive. All rights reserved.
//

import Foundation

extension Int {
    
    // The maximum decimal digit, 9
    static let maxDecimalDigit = 9
    
    // The minimum decimal digit 0
    static let minDecimalDigit = 0
    
    // Array of decimal digits 0-9
    static let decimalDigits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    func ascendingDecimalSequenceTo(_ end: Int) -> [Int] {
        guard
            self <= Int.maxDecimalDigit,
            end <= Int.maxDecimalDigit,
            self >= Int.minDecimalDigit,
            end >= Int.minDecimalDigit else { return [] }
        var array = [Int]()

        if self < end {
            array += Int.decimalDigits[self ... end]
        }
        if end < self {
            array += Int.decimalDigits[self ..< Int.decimalDigits.endIndex]
            array += Int.decimalDigits[0 ... end]
        }
        if self == end {
            array.append(Int.decimalDigits[self])
        }
        return array
    }
    
    func descendingDecimalSequenceTo(_ end: Int) -> [Int] {
        guard
            self <= Int.maxDecimalDigit,
            end <= Int.maxDecimalDigit,
            self >= Int.minDecimalDigit,
            end >= Int.minDecimalDigit else { return [] }

        var array = [Int]()
        
        if self < end {
            array += Int.decimalDigits[end..<Int.decimalDigits.endIndex]
            array += Int.decimalDigits[0...self]
        }
        if end < self {
            array += Int.decimalDigits[end...self]
        }
        if self == end {
            array.append(Int.decimalDigits[self])
        }
        return array.reversed()
    }
}
