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
    // MARK: - Outlets
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var forecastTableView: UITableView!
    // MARK: - Constants
    private enum Features {
        static let cellHeight: CGFloat = 90
        static let headerHeight: CGFloat = 45
    }
    // MARK: - Variables
    private var bag = Set<AnyCancellable>()
    private var viewModel: ForecastViewModel
    // MARK: - Injected properties
    private let locationService: CoreLocationService
    private let apiManager: APIManager
    // MARK: - Custom Init
    init?(coder: NSCoder, locationService: CoreLocationService, apiManager: APIManager) {
        self.locationService = locationService
        self.apiManager = apiManager
        self.viewModel = ForecastViewModel(apiManager: apiManager, locationService: locationService)
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalizedText()
        setupTableView()
        subscribeToPublishers()
    }
    // MARK: - Setup
    private func setupLocalizedText() {
        title = L10n.Forecast.title
    }

    private func setupTableView() {
        forecastTableView.register(R.nib.forecastDayTableViewCell)
    }
    private func subscribeToPublishers() {
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

// MARK: - UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.forecasts.value.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecasts.value[section].1.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastDayTableViewCell,
                                                 for: indexPath)!
        let dayForecasts = viewModel.forecasts
                                    .value[indexPath.section]
        let forecastModel = dayForecasts.1[indexPath.row]
        let isLastElement = dayForecasts.1.count - 1 == indexPath.row
        cell.setupCell(withModel: forecastModel, hideSeparator: isLastElement)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Features.headerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = R.nib.forecastSectionHeaderView.firstView(owner: self)
        headerView?.setHeaderTitle(viewModel.forecasts.value[section].0)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Features.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
