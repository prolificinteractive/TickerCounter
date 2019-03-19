//
//  Int+DecimalSequence.swift
//  TickerCounter
//
//  Created by Kevin Miller  on 3/18/19.
//

import Foundation

extension Int {
    
    func ascendingDecimalSequenceTo(_ end: Int) -> [Int] {
        guard
            self <= 9,
            end <= 9,
            self >= 0,
            end >= 0 else { return [] }
        let decimalDigits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        var array = [Int]()

        if self < end {
            array += decimalDigits[self ... end]
        }
        if end < self {
            array += decimalDigits[self ..< decimalDigits.endIndex]
            array += decimalDigits[0 ... end]
        }
        if self == end {
            array.append(decimalDigits[self])
        }
        return array
    }
    
    func descendingDecimalSequenceTo(_ end: Int) -> [Int] {
        guard
            self <= 9,
            end <= 9,
            self >= 0,
            end >= 0 else { return [] }
        let decimalDigits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        var array = [Int]()
        
        if self < end {
            array += decimalDigits[end..<decimalDigits.endIndex]
            array += decimalDigits[0...self]
        }
        if end < self {
            array += decimalDigits[end...self]
        }
        if self == end {
            array.append(decimalDigits[self])
        }
        return array.reversed()
    }
}
