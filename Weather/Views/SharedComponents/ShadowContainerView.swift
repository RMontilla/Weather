//
//  ShadowContainerView.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit

class ShadowContainerView: UIView {
    @IBInspectable private var shadowOpacity: Float = 0.3
    @IBInspectable private var shadowColor: UIColor = .black
    @IBInspectable private var shadowOffset: CGFloat = 5
    @IBInspectable private var shadowRadius: CGFloat = 2
        
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffset, height: shadowOffset)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
}
