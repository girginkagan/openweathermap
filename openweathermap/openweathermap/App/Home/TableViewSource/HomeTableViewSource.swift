//
//  HomeTableViewSource.swift
//  openweathermap
//
//  Created by Kagan Girgin on 24/07/2025.
//

import UIKit

// MARK: UITableViewDataSource
final class HomeTableViewSource: NSObject, UITableViewDataSource {
    private let data: [[List]]
    
    init(
        data: [[List]]
    ) {
        self.data = data
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        section == 0 ? 1 : data[section].count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DayForecastTableViewCell.description(),
                for: indexPath
            ) as? DayForecastTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.updateCell(data: data[indexPath.section])
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ForecastTableViewCell.description(),
                for: indexPath
            ) as? ForecastTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.updateCell(data: data[indexPath.section][indexPath.row])
            
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension HomeTableViewSource: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        indexPath.section == 0 ? 100 : 60
    }
}
