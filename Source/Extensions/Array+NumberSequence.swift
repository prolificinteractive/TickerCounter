//
//  Array+NumberSequence.swift
//  TickerCounter
//
//  Created by Kevin Miller  on 3/18/19.
//

import Foundation

extension Array where Element == Int {
    
    func stringArray() -> [String] {
        return self.compactMap { String($0) }
    }
}
