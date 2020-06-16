//
//  WeatherViewController.swift
//  Weather
//
//  Created by rafaerum on 2020/06/16.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var locationDescriptionLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var precipitationLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var windDirectionLabel: UILabel!
    
    //MARK: - Variables
    private var bag = Set<AnyCancellable>()
    private var viewModel = WeatherViewModel()
    
    /*init(apiManager: APIManager) {
        self.viewModel = WeatherViewModel(apiManager: apiManager)
        super.init(nibName: R.storyboard.weather.name, bundle: R.storyboard.weather.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedText()
        subscribeToPublishers()
    }
    //MARK: - Setup
    private func setupLocalizedText() {
        titleLabel.text = L10n.Today.title
        title = L10n.Today.title
    }
    
    private func subscribeToPublishers() {
        // Location service
        CoreLocationService.shared.currentCoordinates
            .sink { [weak self] location in
                guard let location = location else { return }
                self?.viewModel.fetchCurrentWeather(location)
            }
            .store(in: &bag)
        
        // View model
        viewModel.weatherImageName
            .sink { [weak self] imageName in
                self?.weatherImageView.image = UIImage(named: imageName)
            }
            .store(in: &bag)
        viewModel.formattedLocation
            .assign(to: \.text, on: locationDescriptionLabel)
            .store(in: &bag)
        viewModel.weatherDescription
            .assign(to: \.text, on: weatherDescriptionLabel)
            .store(in: &bag)
        viewModel.humidity
            .assign(to: \.text, on: humidityLabel)
            .store(in: &bag)
        viewModel.pressure
            .assign(to: \.text, on: pressureLabel)
            .store(in: &bag)
        viewModel.precipitation
            .assign(to: \.text, on: precipitationLabel)
            .store(in: &bag)
        viewModel.windSpeed
            .assign(to: \.text, on: windSpeedLabel)
            .store(in: &bag)
        viewModel.windDirection
            .assign(to: \.text, on: windDirectionLabel)
            .store(in: &bag)
    }
}
