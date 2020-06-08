//
//  RoundedButton.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/08.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    //MARK: - Variables
    @IBInspectable private var cornerRadius: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
