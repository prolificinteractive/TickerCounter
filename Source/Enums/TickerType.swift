//
//  TickerType.swift
//  Ticker Counter
//
//  Created by Kevin Miller  on 3/14/19.
//  Copyright © 2019 Prolific Interactive. All rights reserved.
//

import Foundation

/// This enum describes the basic behavior of the ticker counter
/// case: independent - each "wheel" of the ticker counter rotates independently
/// case: cascade - each "wheel" of the ticker counter starts at the same time but ends at different times
/// case: even - each "wheel" of the ticker starts and ends at the same time
public enum TickerType: Int {
    
    case independent
    case cascade
    case even
    
    func calculationMode() -> UIViewKeyframeAnimationOptions {
        switch self {
        case .independent:
            return .calculationModeLinear
        case .cascade:
            return .calculationModeLinear
        case .even:
            return .calculationModePaced
        }
    }
    
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
