//
//  String+MonospacedWidth.swift
//  TickerCounter
//
//  Created by Kevin Miller  on 3/27/19.
//

import UIKit

extension String {
    
    /// Returns a CGFloat of the width of the receiver as if all the decimal digits were monospaced
    func monospacedStringWidth(attributes: [NSAttributedStringKey: Any]) -> CGFloat {
        let array = self.compactMap { String($0) }
        var stringWidth = CGFloat()
        for string in array {
            if string.isDecimalDigit() {
                stringWidth += NSString(string: "0").size(withAttributes: attributes).width
            } else {
                stringWidth += NSString(string: string).size(withAttributes: attributes).width
            }
        }
        return stringWidth
    }
}
