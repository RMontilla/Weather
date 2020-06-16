//
//  ForecastViewController.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import Combine

class ForecastViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var forecastTableView: UITableView!
    //MARK: - Constants
    private struct Features {
        static let cellHeight: CGFloat = 90
    }
    //MARK: - Variables
    private var bag = Set<AnyCancellable>()
    private var viewModel = ForecastViewModel()
    
    /*init(apiManager: APIManager) {
        self.viewModel = ForecastViewModel(apiManager: apiManager)
        super.init(nibName: R.storyboard.forecast.name, bundle: R.storyboard.forecast.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        subscribeToPublishers()
    }
    //MARK: - Setup
    private func setupTableView() {
        forecastTableView.register(R.nib.forecastDayTableViewCell)
    }
    private func subscribeToPublishers() {
        // Location service
        CoreLocationService.shared.currentCoordinates
            .sink { [weak self] location in
                guard let location = location else { return }
                self?.viewModel.fetchForecast(location)
            }
            .store(in: &bag)
        
        // View model
        viewModel.forecasts
            .sink { [weak self] _ in
                self?.forecastTableView.reloadData()
            }
            .store(in: &bag)
        
        viewModel.cityName
            .assign(to: \.text, on: cityNameLabel)
            .store(in: &bag)
    }
}

//MARK: - UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecasts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastDayTableViewCell,
                                                 for: indexPath)!
        let forecastModel = viewModel.forecasts.value[indexPath.row]
        cell.setupCell(withModel: forecastModel)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return .init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Features.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
