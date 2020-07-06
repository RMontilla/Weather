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
    typealias DataSource = UITableViewDiffableDataSource<String, ForecastDay>
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, ForecastDay>
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
    private var dataSource: DataSource!
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
        dataSource = DataSource(tableView: forecastTableView) { (tableView, indexPath, forecast) -> UITableViewCell? in
                            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastCell,
                                                                     for: indexPath)!
                            let dayForecasts = self.viewModel.forecasts
                                                             .value[indexPath.section]
                            let isLastElement = dayForecasts.1.count - 1 == indexPath.row
                            cell.setupCell(withModel: forecast, hideSeparator: isLastElement)
                            return cell
                     }
    }
    private func subscribeToPublishers() {
        // View model
        viewModel.forecasts
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] forecasts in
                var snapshot = Snapshot()
                snapshot.appendSections(forecasts.map { $0.0 })
                forecasts.forEach { snapshot.appendItems($0.1, toSection: $0.0) }
                self?.dataSource.apply(snapshot)
            }
            .store(in: &bag)
        viewModel.cityName
            .assign(to: \.text, on: cityNameLabel)
            .store(in: &bag)
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
