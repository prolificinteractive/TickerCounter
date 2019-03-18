//
//  String+IsDecimalDigit.swift
//  Pods-TickerCounterDemo
//
//  Created by Kevin Miller  on 3/18/19.
//

import Foundation

extension String {
    
    func isDecimalDigit() -> Bool {
        let decimalSet = CharacterSet.decimalDigits
        let rangeOfCharacter = self.rangeOfCharacter(from: decimalSet)
        return rangeOfCharacter != nil
    }
}
