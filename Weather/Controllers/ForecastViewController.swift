//
//  ForecastViewController.swift
//  Weather
//
//  Created by Rafael Montilla on 2020/06/15.
//  Copyright © 2020 rafael. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var forecastTableView: UITableView!
    //MARK: - Constants
    private struct Features {
        static let cellHeight: CGFloat = 90
    }
    //MARK: - Variables
    private var forecasts: [ForecastDay] = [] {
        didSet {
            forecastTableView.reloadData()
        }
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNotificationObservers()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .locationUpdated, object: nil)
    }
    //MARK: - Setup
    private func setupTableView() {
        forecastTableView.register(R.nib.forecastDayTableViewCell)
    }
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchForecast(_:)), name: .locationUpdated, object: nil)
    }
    
    //MARK: - Fetch methods
    @objc
    private func fetchForecast(_ notification: Notification) {
        print("notificationnnn")
        guard let coordinate = notification.userInfo?[Constants.NotificationKeys.coordinate] as? CLLocationCoordinate2D else {
            print(notification.userInfo ?? "error")
            return
        }
        let request = ForecastRequest(latitude: coordinate.latitude.description, longitude: coordinate.longitude.description)
        print("request")
        APIManager.shared.makeRequest(target: request) { [weak self] (result: Result<ForecastResponse, APIError>) in
            switch result {
            case .success(let response):
                self?.forecasts = response.forecasts
                self?.cityNameLabel.text = response.cityName
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastDayTableViewCell,
                                                 for: indexPath)!
        let forecastModel = forecasts[indexPath.row]
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
