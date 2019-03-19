//
//  TickerType.swift
//  Pods-TickerCounterDemo
//
//  Created by Kevin Miller  on 3/14/19.
//

import Foundation

public enum TickerType: Int {
    
    case independent
    case cascade
    case even
    
    func relativeStartTime(index: Int, count: Int) -> Double {
        switch self {
        case .cascade:
            return 0
        case .independent:
            let offset = 1 / Double(count)
            return Double(index) * offset
        case .even:
            return 0
        }
        
    }
    
    func relativeDurationFor(index: Int, count: Int) -> Double {
        switch self {
        case .cascade:
            return 1 / Double(count - index)
        case .independent:
            return 1 / Double(count)
        case .even:
            return 1
        }
    }
}
