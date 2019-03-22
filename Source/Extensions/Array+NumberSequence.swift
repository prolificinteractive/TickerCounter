//
//  Array+NumberSequence.swift
//  Ticker Counter
//
//  Created by Kevin Miller  on 3/14/19.
//  Copyright © 2019 Prolific Interactive. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    
    func stringArray() -> [String] {
        return self.compactMap { String($0) }
    }
}
