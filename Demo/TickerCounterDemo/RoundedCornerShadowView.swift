//
//  RoundedCornerShadowView.swift
//  TickerCounterDemo
//
//  Created by Kevin Miller  on 3/27/19.
//  Copyright © 2019 Prolific Interactive. All rights reserved.
//

import UIKit

class RoundedCornerShadowView: UIView {

    private var shadowLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = false
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 5
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
