//
//  String+IsDecimalDigit.swift
//  Ticker Counter
//
//  Created by Kevin Miller  on 3/14/19.
//  Copyright © 2019 Prolific Interactive. All rights reserved.
//

import Foundation

extension String {
    
    func isDecimalDigit() -> Bool {
        let decimalSet = CharacterSet.decimalDigits
        let rangeOfCharacter = self.rangeOfCharacter(from: decimalSet)
        return rangeOfCharacter != nil
    }
}
