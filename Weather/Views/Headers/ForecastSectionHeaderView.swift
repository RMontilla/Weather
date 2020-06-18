//
//  ForecastSectionHeaderView.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/18.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit

class ForecastSectionHeaderView: UIView {
    @IBOutlet private weak var headerTitleLabel: UILabel!
    func setHeaderTitle(_ title: String) {
        headerTitleLabel.text = title
    }
}
