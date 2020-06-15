//
//  ForecastDayTableViewCell.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit

protocol ForecastDayCellModel: class {
    var image: UIImage { get }
    var time: String { get }
    var weatherDescription: String { get }
    var temperature: String { get }
}

class ForecastDayTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(withModel model: ForecastDayCellModel) {
        weatherImageView.image = model.image
        timeLabel.text = model.time
        weatherDescriptionLabel.text = model.weatherDescription
        temperatureLabel.text = model.temperature
    }
}
