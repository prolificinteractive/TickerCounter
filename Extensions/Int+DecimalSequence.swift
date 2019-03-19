//
//  Int+DecimalSequence.swift
//  TickerCounter
//
//  Created by Kevin Miller  on 3/18/19.
//

import Foundation

extension Int {
    
    func directDecimalSequenceTo(_ int: Int) -> [Int] {
        let maxInt = Swift.max(self, int)
        let minInt = Swift.min(self, int)
        if minInt < 0 || maxInt > 9 {
            return []
        }
        var array = [Int]()
        for i in minInt...maxInt {
            array.append(i)
        }
        if int < self {
            return array.reversed()
        }
        return array
    }
    
    func indirectDecimalSequenceTo(_ int: Int) -> [Int] {
        let maxInt = Swift.max(self, int)
        let minInt = Swift.min(self, int)
        if minInt < 0 || maxInt > 9 {
            return []
        }
        var array = [Int]()
        for i in minInt...9 {
            array.append(i)
        }
        for i in 0...maxInt {
            array.append(i)
        }
        if int < self {
            return array.reversed()
        }
        return array
    }
}
