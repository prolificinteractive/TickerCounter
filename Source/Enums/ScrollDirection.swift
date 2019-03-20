//
//  ScrollDirection.swift
//  Ticker Counter
//
//  Created by Kevin Miller  on 3/14/19.
//  Copyright © 2019 Prolific Interactive. All rights reserved.
//

import Foundation

/// This enum describes the vertical direction of the animation
/// case: topToBottom - The "wheel" scrolls from the top to the bottom
/// case: bottomToTop - The "wheel" scrolls from the bottom to the top
public enum ScrollDirection: Int {
    case topToBottom
    case bottomToTop
}
