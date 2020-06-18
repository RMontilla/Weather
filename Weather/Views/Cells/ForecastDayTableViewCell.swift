//
//  ForecastDayTableViewCell.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit

protocol ForecastDayCellModel {
    var imageName: String { get }
    var formattedDay: String { get }
    var formattedTime: String { get }
    var weatherDescription: String { get }
    var formattedTemperature: String { get }
}

class ForecastDayTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupCell(withModel model: ForecastDayCellModel,
                   hideSeparator: Bool = false) {
        weatherImageView.image = model.imageName.isEmpty ? nil : UIImage(named: model.imageName)
        timeLabel.text = model.formattedTime
        weatherDescriptionLabel.text = model.weatherDescription
        temperatureLabel.text = model.formattedTemperature
        separatorView.isHidden = hideSeparator
    }
}
