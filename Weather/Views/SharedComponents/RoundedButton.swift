//
//  RoundedButton.swift
//  Weather
//
//  Created by rafaerum on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    //MARK: - Variables
    @IBInspectable private var cornerRadius: CGFloat = 5
    @IBInspectable private var shadowOpacity: Float = 0.3
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = shadowOpacity
    }
}
