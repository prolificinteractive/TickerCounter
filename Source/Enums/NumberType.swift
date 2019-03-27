//
//  NumberType.swift
//  TickerCounter
//
//  Created by Kevin Miller  on 3/26/19.
//

import Foundation

/// The type of number for display in the TickerCounter
///
/// case: currency - The number is formatted as currency, i.e. "$4460.23"
/// case: decimal - The number is formatted as a decimal number, i.e 4460
public enum NumberType {
    case currency
    case decimal
}
